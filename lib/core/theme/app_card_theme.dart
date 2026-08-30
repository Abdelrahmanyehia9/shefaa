import 'package:flutter/material.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

import 'package:shefaa/core/utils/app_colors.dart';

abstract class AppCardTheme {
  const AppCardTheme._();

  static CardThemeData light = _common.copyWith(
    color: AppColors.white,
    shadowColor: Colors.black26,
    elevation: UISizes.sp1,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.grey100, width: 0.5),
      borderRadius: BorderRadius.all(Radius.circular(UISizes.r16)),
    ),
  );

  static CardThemeData dark = _common.copyWith(
    color: AppColors.grey800,
    shadowColor: Colors.black54,
    elevation: 1,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.grey600, width: 0.5),
      borderRadius: BorderRadius.all(Radius.circular(UISizes.r16)),
    ),
  );

  static final CardThemeData _common = const CardThemeData(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.hardEdge,
  );
}
