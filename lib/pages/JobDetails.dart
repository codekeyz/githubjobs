import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githubjobs/core/data/GithubJob.dart';

class JobDetails extends StatefulWidget {
  static final String id = 'JobDetails';
  final GithubJob job;

  const JobDetails({this.job});

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    final _job = widget.job;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, innerScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [StretchMode.blurBackground],
                background: LayoutBuilder(builder: (context, constraints) {
                  final _compLogo = _job.companyLogo;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Spacer(),
                        SizedBox(height: 10),
                        Hero(
                          tag: 'job_${_job.id}',
                          child: Container(
                            height: 80,
                            width: 80,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                        SizedBox(height: 16),
                        Text(
                          '${_job.title}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: 5),
                        Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: '${_job.company} - ${_job.location}',
                              ),
                              TextSpan(
                                text: ' (${_job.type})',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  );
                }),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
