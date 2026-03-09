import 'dart:io';

/// Utility class for checking internet connectivity.
///
/// Uses a DNS lookup to determine whether the device has an active internet
/// connection.
///
/// ```dart
/// final connected = await InternetUtils.isInternetConnected();
/// if (!connected) showOfflineBanner();
/// ```
abstract class InternetUtils {
  static const String _lookUpAddress = 'google.com';

  /// Returns `true` if the device can reach the internet.
  ///
  /// Performs a DNS lookup for `google.com`. Returns `false` on any
  /// [SocketException] or when the lookup returns an empty result.
  static Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup(_lookUpAddress);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {}
    return false;
  }
}
