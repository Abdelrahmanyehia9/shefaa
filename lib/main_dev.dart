import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shefaa/shafi_app.dart';

import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    ScreenUtil.ensureScreenSize(),
    DI.init(),
    // initializeDateFormatting("ar"),
  ]);
  AppRouter router = AppRouter();
  runApp(ShafiApp(router: router));
}
