import 'package:flutter/material.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

import 'package:shefaa/core/utils/app_colors.dart';

abstract class AppCardTheme {
  const AppCardTheme._();

  static CardThemeData light = _common.copyWith(
    color: AppColors.white,
    shadowColor: Colors.black26,
    elevation: UISizes.sp1,
  );

  static CardThemeData dark = _common.copyWith(
    color: AppColors.grey900,
    shadowColor: Colors.black54,
    elevation: 1,
  );

  static final CardThemeData _common = CardThemeData(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(UISizes.r12)),
    ),
  );
}
