import 'package:flutter/material.dart';
import 'package:shefaa/core/utils/app_icons.dart';

extension ThemExt on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  InputDecorationThemeData get inputDecorationTheme =>
      Theme.of(this).inputDecorationTheme;
  Color get primaryColor => colors.primary;
  Color get secondaryColor => colors.secondary;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  double get toolbarHeight => Theme.of(this).appBarTheme.toolbarHeight ?? 0;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get shadowColor => Theme.of(this).shadowColor;
  AppBarThemeData get appBarTheme => Theme.of(this).appBarTheme;
  SwitchThemeData get switchTheme => Theme.of(this).switchTheme;
  ButtonThemeData get buttonTheme => Theme.of(this).buttonTheme;
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
}

extension ThemeModeExt on ThemeMode {
  String get text => switch (this) {
    ThemeMode.light => "نهارى",
    ThemeMode.dark => "مسائي",
    ThemeMode.system => "النظام",
  };
  IconData get icon => switch (this) {
    ThemeMode.light => AppIcons.lightMode,
    ThemeMode.dark => AppIcons.darkMode,
    ThemeMode.system => AppIcons.systemMode,
  };
}
