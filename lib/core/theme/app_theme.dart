import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/theme/app_input_decoration_theme.dart';
import 'package:shefaa/core/theme/app_pin_field_theme.dart';
import 'package:shefaa/core/theme/app_text_theme.dart';
import 'package:shefaa/core/utils/text_styles.dart';

import 'package:shefaa/core/theme/app_appbar_theme.dart';
import 'package:shefaa/core/theme/app_card_theme.dart';
import 'package:shefaa/core/theme/app_color_scheme.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_back_button.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData lightTheme() => ThemeData(
    cardTheme: AppCardTheme.light,
    textTheme: AppTextTheme.textTheme,
    shadowColor: const Color.fromRGBO(12, 12, 12, 0.3),
    scaffoldBackgroundColor: AppColorScheme.scaffoldBackgroundColorLight,
    appBarTheme: AppAppBarTheme.light,
    fontFamily: TextStyles.arMaraiFontFamily,
    disabledColor: AppColors.grey400,
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => Padding(
        padding: EdgeInsetsDirectional.only(start: UISizes.w8),
        child: const AppBackButton(),
      ),
    ),
    inputDecorationTheme: AppInputDecorationTheme.light,
    dividerTheme: DividerThemeData(
      color: AppColors.grey300,
      thickness: UISizes.sp1,
    ),
    colorScheme: AppColorScheme.light,
    extensions: [MaterialPinThemeExtension(theme: AppPinFieldTheme.light)],
  );
  static ThemeData darkTheme() => ThemeData(
    cardTheme: AppCardTheme.dark,
    textTheme: AppTextTheme.textTheme,
    shadowColor: const Color.fromRGBO(12, 12, 12, 0.3),
    scaffoldBackgroundColor: AppColorScheme.scaffoldBackgroundColorDark,
    appBarTheme: AppAppBarTheme.dark,
    fontFamily: TextStyles.arMaraiFontFamily,
    disabledColor: AppColors.grey600,
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => Padding(
        padding: EdgeInsetsDirectional.only(start: UISizes.w8),
        child: const AppBackButton(),
      ),
    ),
    inputDecorationTheme: AppInputDecorationTheme.light,
    dividerTheme: DividerThemeData(
      color: AppColors.grey600,
      thickness: UISizes.sp1,
    ),
    colorScheme: AppColorScheme.dark,
    extensions: [MaterialPinThemeExtension(theme: AppPinFieldTheme.light)],
  );

}
