import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  const TextStyles._();

  static const String enFontFamily = 'noto_sans';
  static const String arTajawelFontFamily = 'tajawal';
  static const String arCairoFontFamily = 'cairo';
  static const String arMaraiFontFamily = 'marai';
  static const double _sizeScaler = 1.1;
  static const double _heightScaler = 1;

  static final TextStyle displayLarge = _style(
    fontSize: 30,
    height: 64 / 57,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle displayMedium = _style(
    fontSize: 26,
    height: 52 / 45,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle displaySmall = _style(
    fontSize: 24,
    height: 44 / 36,
    fontWeight: FontWeightHelper.bold,
  );

  static final TextStyle headlineLarge = _style(
    fontSize: 22,
    height: 40 / 32,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle headlineMedium = _style(
    fontSize: 20,
    height: 36 / 28,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle headlineSmall = _style(
    fontSize: 18,
    height: 32 / 24,
    fontWeight: FontWeightHelper.medium,
  );

  static final TextStyle titleLarge = _style(
    fontSize: 16,
    height: 28 / 22,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle titleMedium = _style(
    fontSize: 14,
    height: 24 / 16,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle titleSmall = _style(
    fontSize: 12,
    height: 20 / 14,
    fontWeight: FontWeightHelper.medium,
  );

  static final TextStyle bodyLarge = _style(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeightHelper.light,
  );
  static final TextStyle bodyMedium = _style(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeightHelper.light,
  );
  static final TextStyle bodySmall = _style(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeightHelper.light,
  );

  static final TextStyle labelLarge = _style(
    fontSize: 16,
    height: 20 / 14,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle labelMedium = _style(
    fontSize: 14,
    height: 16 / 12,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle labelSmall = _style(
    fontSize: 12,
    height: 16 / 11,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle _style({
    required double fontSize,
    required double height,
    required FontWeight fontWeight,
  }) {
    final scaledSize = fontSize * _sizeScaler;
    return TextStyle(
      fontSize: scaledSize.sp,
      height: height.sp * _heightScaler,
      fontWeight: fontWeight,
    );
  }
}

class FontWeightHelper {
  const FontWeightHelper._();
  static const FontWeight light = FontWeight.w300;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;
}
