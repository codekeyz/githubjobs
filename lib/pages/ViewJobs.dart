import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githubjobs/pages/JobDetails.dart';
import 'package:githubjobs/providers/BaseProvider.dart';
import 'package:githubjobs/providers/GithubJobsProvider.dart';
import 'package:provider/provider.dart';

class ViewJobsPage extends StatefulWidget {
  static const String id = 'ViewJobs';

  @override
  _ViewJobsPageState createState() => _ViewJobsPageState();
}

class _ViewJobsPageState extends State<ViewJobsPage> {
  final _searchTextEditingController = TextEditingController();
  final _scrollController = ScrollController();

  bool _isLoadingMore = false;
  String _searchString;
  Timer _searchDebounce;
  GitHubJobsProvider _jobsProvider;

  updateScrollMetrics(ScrollMetrics scrollInfo) async {
    scrollInfo = scrollInfo;
    final _minScroll = scrollInfo.maxScrollExtent * 0.6;
    if (scrollInfo.pixels >= _minScroll && !_isLoadingMore) {
      loadMore();
    }
  }

  void onSearchQueryChanged(String search) {
    if (_searchDebounce?.isActive ?? false) return;
    _searchDebounce = Timer(Duration(milliseconds: 200), () {
      _searchString = search;
      _jobsProvider.fetchJobs(refresh: true, search: _searchString);
    });
  }

  Future<void> loadMore() async {
    _isLoadingMore = true;
    await _jobsProvider.fetchJobs(search: _searchString);
    _isLoadingMore = false;
  }

  void didBuild(BuildContext context) {
    _jobsProvider.fetchJobs();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      didBuild(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    final _isLight = _themeData.brightness == Brightness.light;
    _jobsProvider = Provider.of<GitHubJobsProvider>(context, listen: false);

    return StreamBuilder<JobsEvent>(
        stream: _jobsProvider.stream,
        builder: (context, snapshot) {
          final _isLoading = snapshot.data?.state == ProviderState.LOADING;
          final _jobs = _jobsProvider.githubJobs;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              actions: [
                if (_isLoading)
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: ValueListenableBuilder(
                  valueListenable: _searchTextEditingController,
                  builder: (context, textVal, _) {
                    final _text = textVal.text;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          TextField(
                            controller: _searchTextEditingController,
                            onChanged: onSearchQueryChanged,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: 'Searching for a job?',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              fillColor: _isLight ? Colors.grey[200] : null,
                              prefixIcon: _text.isEmpty ? Icon(Icons.search) : null,
                              suffixIcon: _text.isNotEmpty
                                  ? GestureDetector(
                                      child: Icon(Icons.close),
                                      onTap: () {
                                        onSearchQueryChanged(null);
                                        _searchTextEditingController.clear();
                                      })
                                  : null,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                ),
              ),
              title: SizedBox(
                height: 40,
                width: 40,
                child: Image.asset('assets/img/github.png', color: Colors.white),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () {
                return _jobsProvider.fetchJobs(refresh: true);
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  updateScrollMetrics(scrollInfo.metrics);
                  return false;
                },
                child: Scrollbar(
                  controller: _scrollController,
                  isAlwaysShown: true,
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    separatorBuilder: (_, __) => SizedBox(height: 16),
                    itemBuilder: (_, index) {
                      final _item = _jobs[index];
                      final _compLogo = _item.companyLogo;

                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          title: Text(
                            '${_item.title}',
                            style: _themeData.textTheme.headline6.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${_item.company} - ${_item.type}'),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(child: Text('${_item.location}')),
                                ],
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(JobDetails.id, arguments: {'job': _item});
                          },
                          leading: Hero(
                            tag: 'job_${_item.id}',
                            child: Container(
                              height: 60,
                              width: 60,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.shade100,
                              ),
                              child: _compLogo == null
                                  ? Icon(Icons.emoji_flags)
                                  : CachedNetworkImage(
                                      imageUrl: _compLogo,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (_, __, x) => Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: _jobs.length,
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }
}
