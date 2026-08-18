import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/text_styles.dart';

abstract final class AppPinFieldTheme {
  AppPinFieldTheme._();

  static const MaterialPinTheme dark = MaterialPinTheme(
    fillColor: AppColors.grey800,
    errorBorderWidth: 0.5,
    borderColor: AppColors.grey400,
    focusedFillColor: AppColors.grey800,
    cursorColor: AppColors.white,
    focusedBorderColor: AppColors.grey300,
    focusedBorderWidth: 0.5,
    focusedElevation: 4,
    errorFillColor: AppColors.error600,
    filledFillColor: AppColors.grey800,
    filledBorderColor: AppColors.grey500,
    borderWidth: 0.5,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
  static MaterialPinTheme light = MaterialPinTheme(
    fillColor: Colors.transparent,
    borderColor: AppColors.grey500,
    borderWidth: 1,
    textStyle: TextStyles.labelLarge.copyWith(color: AppColors.black),
    errorTextStyle: TextStyles.labelLarge.copyWith(color: AppColors.error),
    disabledTextStyle: TextStyles.labelLarge.copyWith(color: AppColors.grey400),
    focusedFillColor: Colors.transparent,
    focusedBorderColor: AppColors.primary,
    focusedBorderWidth: 1.5,
    focusedElevation: 4,
    cursorColor: AppColors.primary,
    filledFillColor: Colors.transparent,
    filledBorderColor: AppColors.grey400,
    errorFillColor: Colors.transparent,
    errorBorderColor: AppColors.error500,
    errorBorderWidth: 1.5,

    borderRadius: const BorderRadius.all(Radius.circular(12)),
  );
}
