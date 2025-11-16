import 'dart:math';
import 'dart:developer' as dev;

class Logger {
  static Logger? _instance;

  static void initialize({required bool enableLogging}) {
    _instance ??= Logger(enableLogging: enableLogging);
  }

  static Logger get shared {
    _instance ??= Logger(enableLogging: false);
    return _instance!;
  }

  bool enableLogging;

  Logger({required this.enableLogging});

  String getCorrelationId(String tag, {String? correlationId}) {
    if (correlationId != null) return correlationId;
    final part1 = DateTime.now().millisecondsSinceEpoch.toString();
    final part2 = Random().nextInt(1000);
    final part3 = tag;
    return '$part1-$part2-$part3';
  }

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
