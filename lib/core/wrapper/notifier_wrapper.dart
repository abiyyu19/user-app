import 'dart:developer';

import 'package:flutter/foundation.dart';

class NotifierWrapper<T> {
  NotifierWrapper(final T initialValue) : _notifier = ValueNotifier<T>(initialValue);
  final ValueNotifier<T> _notifier;
  final List<VoidCallback> _listeners = <VoidCallback>[];

  T get value => _notifier.value;
  set value(final T newValue) => _notifier.value = newValue;

  void addListener(final VoidCallback listener) {
    _listeners.add(listener);
    _notifier.addListener(listener);
  }

  void removeListener(final VoidCallback listener) {
    _listeners.remove(listener);
    _notifier.removeListener(listener);
  }

  ValueNotifier<T> get listenable => _notifier;

  void dispose() {
    _listeners
      ..forEach(_notifier.removeListener)
      ..clear();
    _notifier.dispose();
    if (_listeners.isNotEmpty) log('Listeners disposed', name: 'NotifierWrapper');
    log('NotifierWrapper disposed', name: 'NotifierWrapper');
  }
}
