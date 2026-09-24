import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

enum PermissionResult {
  granted,
  denied,
  permanentlyDenied,
  restricted ;


  bool get isGranted => this == granted ;
  bool get isDenied => this == denied ;
  bool get isPermanentlyDenied => this == permanentlyDenied ;
  bool get isRestricted => this == restricted ;
}

class PermissionHandler {
  const PermissionHandler();

  Future<PermissionResult> checkAndRequest(
      Permission permission,
      ) async {
    final status = await permission.status;

    if (status.isGranted) {
      return PermissionResult.granted;
    }

    if (status.isPermanentlyDenied) {
      return PermissionResult.permanentlyDenied;
    }

    if (status.isRestricted) {
      return PermissionResult.restricted;
    }

    final result = await permission.request();

    if (result.isGranted) {
      return PermissionResult.granted;
    }

    if (result.isPermanentlyDenied) {
      return PermissionResult.permanentlyDenied;
    }

    return PermissionResult.denied;
  }

  Future<bool> openSettings() => openAppSettings();

  Permission get photos {
    if (Platform.isIOS) {
      return Permission.photos;
    }

    return Permission.photos;
  }
}