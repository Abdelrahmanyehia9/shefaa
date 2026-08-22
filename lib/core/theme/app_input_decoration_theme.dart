import 'package:flutter/material.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/text_styles.dart';

class AppInputDecorationTheme {
  const AppInputDecorationTheme._();

  static InputDecorationThemeData get light => InputDecorationThemeData(
    contentPadding: EdgeInsets.symmetric(
      horizontal: UISizes.sp12,
      vertical: UISizes.sp12,
    ),
    errorStyle: TextStyles.labelSmall.copyWith(color: AppColors.error),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.error),
    ),
    labelStyle: TextStyles.bodyLarge.copyWith(color: AppColors.grey600),
    floatingLabelStyle: TextStyles.labelLarge.copyWith(
      color: AppColors.primary,
    ),
  );
  static InputDecorationThemeData get dark => InputDecorationThemeData(
    filled: true,
    fillColor: AppColors.grey900,
    errorStyle: TextStyles.bodySmall,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.grey700),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.grey700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.error400),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISizes.r12),
      gapPadding: 12,
      borderSide: const BorderSide(color: AppColors.error600),
    ),
    hintStyle: TextStyles.bodySmall.copyWith(
      fontSize: UISizes.sp16,
      color: AppColors.grey100,
    ),
  );
}
