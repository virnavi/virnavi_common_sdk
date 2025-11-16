import 'dart:io';

abstract class InternetUtils {
  static const String _lookUpAddress = 'google.com';

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
