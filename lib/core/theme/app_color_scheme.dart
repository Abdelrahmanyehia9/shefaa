import 'package:flutter/material.dart';

import 'package:shefaa/core/utils/app_colors.dart';

abstract class AppColorScheme {
  const AppColorScheme._();

  static const Color scaffoldBackgroundColorLight = Color.fromRGBO(
    245,
    245,
    255,
    1,
  );
  static const Color scaffoldBackgroundColorDark = Color.fromRGBO(
    20,
    20,
    20,
    1,
  );

  static const ColorScheme dark = ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.primary700,
    onPrimaryContainer: AppColors.primary100,

    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.secondary700,
    onSecondaryContainer: AppColors.secondary100,

    tertiary: AppColors.tertiary,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.tertiary700,
    onTertiaryContainer: AppColors.tertiary100,

    error: AppColors.error400,
    onError: AppColors.white,
    errorContainer: AppColors.error700,
    onErrorContainer: AppColors.error100,

    surface: AppColors.black,
    onSurfaceVariant: AppColors.grey200,

    surfaceContainerLowest: AppColors.grey800,
    surfaceContainerLow: AppColors.grey600,
    surfaceContainer: AppColors.grey500,
    surfaceContainerHigh: AppColors.grey300,
    surfaceContainerHighest: AppColors.grey200,

    outline: AppColors.grey400,
    outlineVariant: AppColors.grey600,

    inverseSurface: AppColors.grey100,
    onInverseSurface: AppColors.black,
    inversePrimary: AppColors.primary400,

    shadow: Colors.white24,
    scrim: Colors.black54,
  );

  static const ColorScheme light = ColorScheme.light(
    primary: AppColors.primary400,
    primaryContainer: AppColors.primary100,
    onPrimaryContainer: AppColors.primary700,

    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.secondary100,
    onSecondaryContainer: AppColors.secondary700,

    tertiary: AppColors.tertiary,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.tertiary100,
    onTertiaryContainer: AppColors.tertiary700,

    error: AppColors.error,
    errorContainer: AppColors.error100,
    onErrorContainer: AppColors.error700,
    onSurfaceVariant: AppColors.grey700,

    surfaceContainerLowest: AppColors.grey100,
    surfaceContainerLow: AppColors.grey300,
    surfaceContainer: AppColors.grey500,
    surfaceContainerHigh: AppColors.grey600,
    surfaceContainerHighest: AppColors.grey700,

    outline: AppColors.grey500,
    outlineVariant: AppColors.grey300,

    inverseSurface: AppColors.grey800,
    onInverseSurface: AppColors.white,
    inversePrimary: AppColors.primary,

    shadow: Colors.black26,
    scrim: Colors.black54,
  );
}
