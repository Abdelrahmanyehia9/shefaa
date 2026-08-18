import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  const TextStyles._();

  static const String enFontFamily = 'noto_sans';
  static const String arFontFamily = 'tajawal';

  static const double _sizeScaler = 1.1;
  static const double _heightScaler = 1;
  static const double _letterSpacingScaler = 1.0;

  static final TextStyle displayLarge = _style(
    fontSize: 30,
    height: 64 / 57,
    letterSpacing: -0.25,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle displayMedium = _style(
    fontSize: 26,
    height: 52 / 45,
    letterSpacing: 0,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle displaySmall = _style(
    fontSize: 24,
    height: 44 / 36,
    letterSpacing: 0,
    fontWeight: FontWeightHelper.bold,
  );

  static final TextStyle headlineLarge = _style(
    fontSize: 22,
    height: 40 / 32,
    letterSpacing: 0,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle headlineMedium = _style(
    fontSize: 20,
    height: 36 / 28,
    letterSpacing: 0,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle headlineSmall = _style(
    fontSize: 18,
    height: 32 / 24,
    letterSpacing: 0,
    fontWeight: FontWeightHelper.medium,
  );

  static final TextStyle titleLarge = _style(
    fontSize: 16,
    height: 28 / 22,
    letterSpacing: 0,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle titleMedium = _style(
    fontSize: 14,
    height: 24 / 16,
    letterSpacing: 0.15,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle titleSmall = _style(
    fontSize: 12,
    height: 20 / 14,
    letterSpacing: 0.1,
    fontWeight: FontWeightHelper.bold,
  );

  static final TextStyle bodyLarge = _style(
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.5,
    fontWeight: FontWeightHelper.regular,
  );
  static final TextStyle bodyMedium = _style(
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.25,
    fontWeight: FontWeightHelper.regular,
  );
  static final TextStyle bodySmall = _style(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.4,
    fontWeight: FontWeightHelper.regular,
  );

  static final TextStyle labelLarge = _style(
    fontSize: 16,
    height: 20 / 14,
    letterSpacing: 0.1,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle labelMedium = _style(
    fontSize: 14,
    height: 16 / 12,
    letterSpacing: 0.5,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle labelSmall = _style(
    fontSize: 12,
    height: 16 / 11,
    letterSpacing: 0.5,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle _style({
    required double fontSize,
    required double height,
    required double letterSpacing,
    required FontWeight fontWeight,
  }) {
    final scaledSize = fontSize * _sizeScaler;
    return TextStyle(
      fontSize: scaledSize.sp,
      height: height.sp * _heightScaler,
      letterSpacing: letterSpacing.sp * _letterSpacingScaler,
      fontWeight: fontWeight,
    );
  }
}

class FontWeightHelper {
  const FontWeightHelper._();
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}
