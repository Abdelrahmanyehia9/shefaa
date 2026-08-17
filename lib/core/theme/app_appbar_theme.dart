import 'package:flutter/material.dart';

import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';

abstract final class AppAppBarTheme {
  const AppAppBarTheme._();

  static AppBarTheme light = _common.copyWith(
    foregroundColor: AppColors.black,
    backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
  );

  static final AppBarTheme dark = _common.copyWith(
    foregroundColor: AppColors.white,
    backgroundColor: AppColors.grey1000,
  );

  static final AppBarTheme _common = AppBarTheme(
    toolbarHeight: UISizes.h48,
    leadingWidth: UISizes.h72,
    scrolledUnderElevation: 0,
    actionsPadding: EdgeInsetsGeometry.directional(end: UISizes.w16),
  );
}
