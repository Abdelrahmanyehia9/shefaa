import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:shefaa/core/enum/user_role.dart';

class AppConfigs {
  static UserRole appRole = UserRole.patient  ;
  static const mapToken = String.fromEnvironment('ACCESS_TOKEN');

  static Future<void> init() async {
    await _setupPhoneSystem();
    _setupMapToken() ;
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

  static void _setupMapToken(){
    MapboxOptions.setAccessToken(mapToken);  }
}
