import 'package:flutter/services.dart';

class AppConfigs {
  static Future<void> init() async {
    await _setupPhoneSystem();
  }

  static Future<void> _setupPhoneSystem() async {
    await Future.wait([
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }
}
