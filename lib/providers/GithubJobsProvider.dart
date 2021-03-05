import 'package:githubjobs/core/data/GithubJob.dart';
import 'package:githubjobs/providers/BaseProvider.dart';
import 'package:githubjobs/services/ApiService.dart';
import 'package:githubjobs/services/serviceFactory.dart';
import 'package:githubjobs/utils/network_error.dart';
import 'package:meta/meta.dart';

class JobsEvent<T> {
  final ProviderState state;
  final T data;

  const JobsEvent({
    this.data,
    @required this.state,
  });
}

class GitHubJobsProvider extends BaseProvider<JobsEvent> {
  final Map<String, GithubJob> _githubJobsMap = {};

  int _currentPage;

  ApiService get _apiSvc => sl.get<ApiService>();

  List<GithubJob> get githubJobs => _githubJobsMap.values.toList();

  Future<void> fetchJobs({
    bool refresh = false,
    String search,
  }) async {
    addEvent(JobsEvent(state: ProviderState.LOADING));

    if (refresh) {
      _currentPage = null;
    }

    try {
      final _pageToFetch = (_currentPage ?? 0) + 1;
      final _jobs = await _apiSvc.getJobs(page: _pageToFetch, search: search);

      if (refresh) {
        _githubJobsMap.clear();
      }

      for (final job in _jobs) {
        _githubJobsMap[job.id] = job;
      }

      _currentPage = _pageToFetch;
      notifyListeners();

      addEvent(JobsEvent(state: ProviderState.SUCCESS));
    } on NetworkError catch (e) {
      addEvent(JobsEvent<NetworkError>(state: ProviderState.ERROR, data: e));
    }
  }
}
