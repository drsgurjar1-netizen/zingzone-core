import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class SecurityService {
  // Check if device is compromised (Root / Jailbreak / Developer Tamper)
  static Future<bool> isDeviceSecure() async {
    try {
      bool isJailbroken = await FlutterJailbreakDetection.jailbroken;
      bool isDevMode = await FlutterJailbreakDetection.developerMode;

      if (isJailbroken) {
        return false;
      }

      // Check for common emulator and rooting artifacts on Android
      if (Platform.isAndroid) {
        if (await _checkForRootFiles() || _isEmulator()) {
          return false;
        }
      }

      return true;
    } catch (e) {
      // In case of error reading integrity, fail-safe to blocking untrusted calls
      return false;
    }
  }

  // Look for su binaries and hacking packages
  static Future<bool> _checkForRootFiles() async {
    final List<String> paths = [
      "/system/app/Superuser.apk",
      "/sbin/su",
      "/system/bin/su",
      "/system/xbin/su",
      "/data/local/xbin/su",
      "/data/local/bin/su",
      "/system/sd/xbin/su",
      "/system/bin/failsafe/su",
      "/data/local/su",
      "/su/bin/su"
    ];

    for (String path in paths) {
      if (await File(path).exists()) {
        return true;
      }
    }
    return false;
  }

  // Detect virtual machines and bot emulators
  static bool _isEmulator() {
    return Platform.environment.containsKey('ANDROID_EMULATOR') ||
        Platform.isFuchsia;
  }

  // Force kill the application if tampering or MOD signature is detected
  static void killApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    exit(0);
  }
}

