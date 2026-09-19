import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shefaa/core/utils/app_configs.dart';
import 'package:shefaa/shefaa_app.dart';

import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/routing/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://bdpceetislgzwpsqyfws.supabase.co",
    publishableKey: "sb_publishable_VfE8k7Nvjw0UbYclsApMSw_wTddlFCk",

  );
  await Future.wait([
    ScreenUtil.ensureScreenSize(),
    DI.init(),
    AppConfigs.init(),
    initializeDateFormatting("ar"),
  ]);
  AppRouter router = AppRouter();
  runApp(ShefaaApp(router: router));
}
