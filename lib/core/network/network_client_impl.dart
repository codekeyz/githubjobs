import 'dart:convert';

import 'package:githubjobs/core/network/network_client.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class NetworkClientImpl implements NetworkClient<http.Response> {
  final connectionChecker = Connectivity();

  @override
  Future<bool> get isConnected async {
    final result = await connectionChecker.checkConnectivity();
    final isConnectedWithMobile = result == ConnectivityResult.mobile;
    final isConnectedWithWifi = result == ConnectivityResult.wifi;

    return isConnectedWithMobile || isConnectedWithWifi;
  }

  @override
  Future<http.Response> get(
    String url, {
    Map<String, String> headers = const {},
  }) {
    return http.get(url, headers: headers);
  }

  @override
  Future<http.Response> post(
    String url, {
    Map<String, String> headers = const {},
    dynamic body,
  }) {
    return http.post(
      url,
      body: body,
      headers: headers,
    );
  }

  @override
  Future<http.Response> put(
    String url, {
    Map<String, String> headers = const {},
    dynamic body,
  }) {
    return http.put(
      url,
      headers: headers,
      body: body is Map ? json.encode(body) : body,
    );
  }

  @override
  Future<http.Response> patch(
    String url, {
    Map<String, String> headers = const {},
    body,
  }) {
    return http.patch(
      url,
      headers: headers,
      body: body is Map ? json.encode(body) : body,
    );
  }

  @override
  Future<http.Response> delete(
    String url, {
    Map<String, String> headers = const {},
  }) {
    return http.delete(
      url,
      headers: headers,
    );
  }

  @override
  bool requestIsSuccessFul(
    http.Response r, {
    checkBody: false,
  }) {
    return r != null && r.statusCode >= 200 && r.statusCode < 400 && (checkBody ? r.body != null : true);
  }

  @override
  getResponseBody(http.Response response) {
    try {
      return json.decode(response.body);
    } on FormatException catch (_) {
      return response.body;
    }
  }
}
