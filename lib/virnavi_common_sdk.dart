library virnavi_common_sdk;

import 'src/logger/logger.dart';

export 'src/models/models.dart';
export 'src/utils/utils.dart';
export 'src/wrappers/wrappers.dart';
export 'src/streams/streams.dart';
export 'src/logger/logger.dart';

class VirnaviCommonSdk {
  static VirnaviCommonSdk? _instance;

  static VirnaviCommonSdk get shared {
    if (_instance == null) {
      throw Exception('VirnaviCommonSdk not initialized');
    }
    return _instance!;
  }

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
