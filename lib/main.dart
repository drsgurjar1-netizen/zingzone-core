import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'services/admob_service.dart';
import 'services/security_service.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Lock Screen Orientation to Portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set System Navigation & Status Bar Color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF060709),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // 2. Anti-Tamper & Root Detection Check
  bool isSecure = await SecurityService.isDeviceSecure();
  if (!isSecure) {
    SecurityService.killApp();
    return;
  }

  // 3. Initialize AdMob Ads Engine
  await AdMobService.initialize();

  runApp(const ZingZoneApp());
}

class ZingZoneApp extends StatelessWidget {
  const ZingZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZingZone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF060709),
        primaryColor: const Color(0xFF8A2BE2),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8A2BE2),
          secondary: Color(0xFF00F0FF),
          surface: Color(0xFF131522),
        ),
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

