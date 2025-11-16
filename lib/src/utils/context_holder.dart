import 'package:flutter/widgets.dart';

class ContextHolder {
  /// root app navigator key.
  /// set this key to your root app's navigatorKey.
  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get currentContext {
    return navigatorKey.currentContext!;
  }

  static NavigatorState? get currentState {
    return navigatorKey.currentState;
  }

  static Widget get currentWidget {
    return navigatorKey.currentWidget!;
  }

  static OverlayState get currentOverlay {
    return navigatorKey.currentState!.overlay!;
  }
}
