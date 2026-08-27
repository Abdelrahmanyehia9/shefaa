import 'package:flutter/material.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/text_styles.dart';

abstract class AppTabBarTheme {
  static TabBarThemeData get light => TabBarThemeData(
    labelStyle: TextStyles.labelLarge,
    indicatorAnimation: TabIndicatorAnimation.linear,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: AppColors.grey200,
    labelColor: AppColors.primary,
    dividerHeight: UISizes.sp1,
    splashBorderRadius: BorderRadius.circular(UISizes.r12),
    labelPadding: EdgeInsets.symmetric(vertical: UISizes.sp8),
    unselectedLabelColor: AppColors.grey600,
    unselectedLabelStyle: TextStyles.labelLarge,
  );
}
