// lib/util/lifecycle_event_handler.dart
import 'dart:async';
import 'package:flutter/widgets.dart';

typedef FutureVoidCallback = FutureOr<void> Function(AppLifecycleState state);

class LifecycleEventHandler extends WidgetsBindingObserver {
  final FutureVoidCallback onResume;
  final FutureVoidCallback onSuspend;

  LifecycleEventHandler({this.onResume, this.onSuspend});

//  @override
//  Future<bool> didPopRoute()

//  @override
//  void didHaveMemoryPressure()

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await onSuspend(state);
        break;
      case AppLifecycleState.resumed:
        await onResume(state);
        break;
    }
    print('state change: $state');
  }

//  @override
//  void didChangeLocale(Locale locale)

//  @override
//  void didChangeTextScaleFactor()

//  @override
//  void didChangeMetrics();

//  @override
//  Future<bool> didPushRoute(String route)
}