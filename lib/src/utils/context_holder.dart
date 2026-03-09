import 'package:flutter/widgets.dart';

/// Provides global access to the app's navigation context without requiring
/// a [BuildContext] to be passed down the widget tree.
///
/// Assign [navigatorKey] to your root [MaterialApp] / [WidgetsApp]:
///
/// ```dart
/// MaterialApp(
///   navigatorKey: ContextHolder.navigatorKey,
///   home: const HomePage(),
/// );
/// ```
class ContextHolder {
  /// The global key attached to the root [Navigator].
  ///
  /// Set this as `navigatorKey` on your root app widget so that
  /// [currentContext], [currentState], [currentWidget], and [currentOverlay]
  /// are available from anywhere in the app.
  static final navigatorKey = GlobalKey<NavigatorState>();

  /// The current [BuildContext] of the root navigator.
  ///
  /// Throws if [navigatorKey] has not been attached yet.
  static BuildContext get currentContext {
    return navigatorKey.currentContext!;
  }

  /// The current [NavigatorState], or `null` if not yet attached.
  static NavigatorState? get currentState {
    return navigatorKey.currentState;
  }

  /// The current root widget.
  ///
  /// Throws if [navigatorKey] has not been attached yet.
  static Widget get currentWidget {
    return navigatorKey.currentWidget!;
  }

  /// The current [OverlayState] of the root navigator.
  ///
  /// Throws if [navigatorKey] has not been attached yet.
  static OverlayState get currentOverlay {
    return navigatorKey.currentState!.overlay!;
  }
}
