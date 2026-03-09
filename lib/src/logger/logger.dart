import 'dart:math';
import 'dart:developer' as dev;

/// A singleton logger with correlation-ID support.
///
/// Initialise once via [Logger.initialize] (or rely on the lazy default).
/// Then use [Logger.shared] to obtain the instance.
///
/// ```dart
/// final cId = Logger.shared.log('user signed in', tag: 'Auth');
/// // later, correlate related messages:
/// Logger.shared.log('token refreshed', correlationId: cId);
/// ```
class Logger {
  static Logger? _instance;

  /// Initialises the singleton with the given [enableLogging] flag.
  ///
  /// A no-op if already initialised.
  static void initialize({required bool enableLogging}) {
    _instance ??= Logger(enableLogging: enableLogging);
  }

  /// Returns the shared [Logger] instance, creating one with logging disabled
  /// if [initialize] has not been called.
  static Logger get shared {
    _instance ??= Logger(enableLogging: false);
    return _instance!;
  }

  /// Whether log output is active.
  bool enableLogging;

  /// Creates a [Logger] with the given [enableLogging] flag.
  Logger({required this.enableLogging});

  /// Returns a unique correlation ID for [tag], or [correlationId] if provided.
  ///
  /// The generated ID combines the current timestamp, a random integer, and
  /// [tag] to help trace related log messages across the application.
  String getCorrelationId(String tag, {String? correlationId}) {
    if (correlationId != null) return correlationId;
    final part1 = DateTime.now().millisecondsSinceEpoch.toString();
    final part2 = Random().nextInt(1000);
    final part3 = tag;
    return '$part1-$part2-$part3';
  }

  /// Logs [message] and returns its correlation ID.
  ///
  /// If [correlationId] is supplied it is reused; otherwise a new one is
  /// generated from [tag]. The correlation ID is prepended to the log line so
  /// that related messages can be grouped together.
  String log(
    String message, {
    String tag = '',
    String? correlationId,
  }) {
    final cId = getCorrelationId(tag, correlationId: correlationId);
    dev.log('$cId    $message');
    return cId;
  }
}
