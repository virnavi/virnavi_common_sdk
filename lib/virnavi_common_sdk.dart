/// The main entry point for the Virnavi Common SDK.
///
/// Call [VirnaviCommonSdk.initialize] once at app startup before accessing
/// [VirnaviCommonSdk.shared].
///
/// ```dart
/// void main() {
///   VirnaviCommonSdk.initialize(enableLogging: true);
///   runApp(const MyApp());
/// }
/// ```
library;

import 'src/logger/logger.dart';

export 'src/exceptions/exports.dart';
export 'src/models/models.dart';
export 'src/utils/utils.dart';
export 'src/wrappers/wrappers.dart';
export 'src/streams/streams.dart';
export 'src/logger/logger.dart';

/// Singleton entry point for the Virnavi Common SDK.
///
/// Must be initialised via [initialize] before [shared] is accessed.
class VirnaviCommonSdk {
  static VirnaviCommonSdk? _instance;

  /// Returns the initialised SDK instance.
  ///
  /// Throws an [Exception] if [initialize] has not been called yet.
  static VirnaviCommonSdk get shared {
    if (_instance == null) {
      throw Exception('VirnaviCommonSdk not initialized');
    }
    return _instance!;
  }

  /// Initialises the SDK.
  ///
  /// Must be called once before accessing [shared].
  /// Throws an [Exception] if called more than once.
  ///
  /// [enableLogging] controls whether [Logger] output is active.
  static VirnaviCommonSdk initialize({required bool enableLogging}) {
    if (_instance != null) {
      throw Exception('VirnaviCommonSdk already initialized');
    }
    _instance = VirnaviCommonSdk._(enableLogging: enableLogging);
    return _instance!;
  }

  VirnaviCommonSdk._({required bool enableLogging}) {
    Logger.initialize(enableLogging: enableLogging);
  }
}
