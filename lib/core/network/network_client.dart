abstract class NetworkClient<T> {
  Future<bool> get isConnected;

  Future<T> get(
    String url, {
    Map<String, String> headers = const {},
  });

  Future<T> post(
    String url, {
    Map<String, String> headers = const {},
    dynamic body,
  });

  Future<T> patch(
    String url, {
    Map<String, String> headers = const {},
    dynamic body,
  });

  Future<T> put(
    String url, {
    Map<String, String> headers = const {},
    dynamic body,
  });

  Future<T> delete(
    String url, {
    Map<String, String> headers = const {},
  });

  bool requestIsSuccessFul(
    T response, {
    bool checkBody = false,
  });

  dynamic getResponseBody(T response);
}
