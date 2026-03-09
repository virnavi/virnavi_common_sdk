import 'package:flutter/material.dart';

/// Displays snackbars without requiring a [BuildContext].
///
/// Attach [key] to your root [MaterialApp]'s `scaffoldMessengerKey`:
///
/// ```dart
/// MaterialApp(
///   scaffoldMessengerKey: SnackBarHelper.key,
///   home: const HomePage(),
/// );
/// ```
///
/// Then show a snackbar from anywhere:
///
/// ```dart
/// SnackBarHelper.showSnackBar(
///   const SnackBar(content: Text('Saved!')),
/// );
/// ```
abstract class SnackBarHelper {
  /// The global key attached to the root [ScaffoldMessenger].
  static final key = GlobalKey<ScaffoldMessengerState>();

  /// Shows [snackBar], first dismissing any currently visible snackbar.
  ///
  /// Returns the [ScaffoldFeatureController] for the new snackbar, or `null`
  /// if [key] has not been attached yet.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      showSnackBar(SnackBar snackBar, {BuildContext? context}) {
    close();
    if (context != null) {}
    return key.currentState?.showSnackBar(snackBar);
  }

  /// Dismisses all currently displayed snackbars.
  static void close() => key.currentState?.clearSnackBars();
}
