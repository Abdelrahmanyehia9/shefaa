import 'package:flutter/material.dart';
import 'package:shefaa/core/theme/app_text_theme.dart';
import 'package:shefaa/core/utils/text_styles.dart';

import 'package:shefaa/core/theme/app_appbar_theme.dart';
import 'package:shefaa/core/theme/app_card_theme.dart';
import 'package:shefaa/core/theme/app_color_scheme.dart';
import 'package:shefaa/core/utils/app_colors.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData lightTheme() => ThemeData(
    cardTheme: AppCardTheme.light,
    textTheme: AppTextTheme.textTheme,
    shadowColor: const Color.fromRGBO(12, 12, 12, 0.3),
    scaffoldBackgroundColor: AppColorScheme.scaffoldBackgroundColorLight,
    appBarTheme: AppAppBarTheme.light,
    fontFamily: TextStyles.arFontFamily,
    disabledColor: AppColors.grey400,
    dividerTheme: const DividerThemeData(
      color: AppColors.grey300,
      thickness: 1,
    ),
    colorScheme: AppColorScheme.light,
  );

  static ThemeData darkTheme() => ThemeData(
    cardTheme: AppCardTheme.dark,
    textTheme: AppTextTheme.textTheme,
    shadowColor: const Color.fromRGBO(200, 200, 200, 0.1),
    scaffoldBackgroundColor: AppColorScheme.scaffoldBackgroundColorDark,
    appBarTheme: AppAppBarTheme.dark,
    disabledColor: AppColors.grey700,
  );
}
