import 'dart:async';

import 'package:flutter/widgets.dart';

enum ProviderState { IDLE, LOADING, SUCCESS, ERROR }

abstract class BaseProvider<T> with ChangeNotifier {
  final _streamController = StreamController<T>.broadcast();

  Stream<T> get stream => _streamController.stream;

  @protected
  Sink<T> get sink => _streamController.sink;

  T _lastEvent;

  T get lastEvent => _lastEvent;

  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @protected
  addEvent(T event) {
    _lastEvent = event;
    sink.add(lastEvent);
  }
}
