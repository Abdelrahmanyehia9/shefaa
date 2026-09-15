import 'package:flutter/material.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';

abstract class AppExpansionTileTheme {
  static ExpansionTileThemeData light = ExpansionTileThemeData(
    childrenPadding: EdgeInsets.symmetric(vertical: UISizes.h16),
    expandedAlignment: AlignmentDirectional.centerStart,
    collapsedShape: const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey200),
    ),
    shape: const UnderlineInputBorder(borderSide: BorderSide.none),
  );
}
