/* import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
enum PermissionResult { granted, denied, permanentlyDenied, restricted }


class PermissionHandler {
  static Future<PermissionResult> checkAndRequest(Permission permission) async {
    PermissionStatus status = await permission.status;

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
    } else if (result.isPermanentlyDenied) {
      return PermissionResult.permanentlyDenied;
    } else {
      return PermissionResult.denied;
    }
  }

  static Future<bool> goToAppSettings() async {
    return await openAppSettings();
  }

  static Permission getPhotoPermission() {
    if (Platform.isAndroid) {
      return Permission.photos;
    } else {
      return Permission.photosAddOnly;
    }
  }
} */
