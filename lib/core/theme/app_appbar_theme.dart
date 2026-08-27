import 'package:flutter/material.dart';

import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';

abstract final class AppAppBarTheme {
  const AppAppBarTheme._();

  static AppBarTheme light = _common.copyWith(foregroundColor: AppColors.black);

  static final AppBarTheme dark = _common.copyWith(
    foregroundColor: AppColors.white,
  );

  static final AppBarTheme _common = AppBarTheme(
    toolbarHeight: UISizes.h56,
    backgroundColor: Colors.transparent,
    leadingWidth: UISizes.sp72,
    scrolledUnderElevation: 0,
    centerTitle: true,
    actionsPadding: EdgeInsetsGeometry.directional(end: UISizes.w16),
  );
}
