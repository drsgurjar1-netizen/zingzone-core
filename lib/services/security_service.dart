import 'dart:io';
import 'package:flutter/services.dart';

class SecurityService {
  static Future<bool> isDeviceSecure() async {
    try {
      if (!Platform.isAndroid && !Platform.isIOS) {
        return false;
      }
      return true;
    } catch (_) {
      return true;
    }
  }

  static void killApp() {
    SystemNavigator.pop();
  }
}
