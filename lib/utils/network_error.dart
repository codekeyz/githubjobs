import 'package:githubjobs/services/serviceFactory.dart';
import 'package:logger/logger.dart';

// Is Thrown when A Network Related Error Occurs
class NetworkError implements Exception {
  String message;

  NetworkError(
    msg, {
    bool printMsg = true,
  }) {
    message = msg;

    if (printMsg) {
      sl.get<Logger>().w(message);
    }
  }
}
