import 'package:githubjobs/core/data/GithubJob.dart';
import 'package:githubjobs/core/network/network_client.dart';
import 'package:githubjobs/utils/encode_map.dart';
import 'package:githubjobs/utils/network_error.dart';

class ApiService {
  NetworkClient _netClient;
  String _baseUrl;
  ApiService._(
    this._netClient,
    this._baseUrl,
  );

  factory ApiService.create(
    NetworkClient client, {
    String baseUrl = 'https://jobs.github.com/positions.json',
  }) {
    return ApiService._(client, baseUrl);
  }

  Future<List<GithubJob>> getJobs({
    int page = 1,
    String search,
  }) async {
    final _options = {
      if (page != null) "page": page,
      if (search != null) "search": search,
    };

    final _result = await _netClient.get('$_baseUrl?${encodeMap(_options)}');
    final _requestBody = _netClient.getResponseBody(_result);

    if (!_netClient.requestIsSuccessFul(_result)) {
      throw NetworkError(_requestBody);
    } else if (_requestBody is! Iterable) {
      throw NetworkError(_requestBody);
    }

    return (_requestBody as Iterable).map((e) => GithubJob.fromJson(e)).toList();
  }
}
