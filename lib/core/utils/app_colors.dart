import 'dart:ui';

class AppColors {
  const AppColors._();
  // ─── Primary ───────────────────────────────────────────
  static const Color primary100 = Color(0xFFEDF2FF);
  static const Color primary200 = Color(0xFFD5DFFF);
  static const Color primary300 = Color(0xFFB0C2FF);
  static const Color primary400 = Color(0xFF7697F7);
  static const Color primary500 = Color(0xFF3C6CF2);
  static const Color primary600 = Color(0xFF315CD6);
  static const Color primary700 = Color(0xFF284DB8);
  static const Color primary800 = Color(0xFF203E96);
  static const Color primary900 = Color(0xFF182F73);

  static const Color primary = primary500;
  // ─── Secondary ─────────────────────────────────────────

  static const Color secondary100 = Color(0xFFFBE9EC);
  static const Color secondary200 = Color(0xFFF5C4CC);
  static const Color secondary300 = Color(0xFFE996A3);
  static const Color secondary400 = Color(0xFFD95F70);
  static const Color secondary500 = Color(0xFFB51D34);
  static const Color secondary600 = Color(0xFF99182C);
  static const Color secondary700 = Color(0xFF7D1424);
  static const Color secondary800 = Color(0xFF61101C);
  static const Color secondary900 = Color(0xFF450B14);

  static const Color secondary = secondary500;

  // ─── Tertiary ─────────────────────────────────────────

  static const Color tertiary100 = Color(0xFFE0F5EF);
  static const Color tertiary200 = Color(0xFFB3E5D7);
  static const Color tertiary300 = Color(0xFF80D3BE);
  static const Color tertiary400 = Color(0xFF4FBEA2);
  static const Color tertiary500 = Color(0xFF03A172);
  static const Color tertiary600 = Color(0xFF028A61);
  static const Color tertiary700 = Color(0xFF027250);
  static const Color tertiary800 = Color(0xFF015A3F);
  static const Color tertiary900 = Color(0xFF01402D);

  static const Color tertiary = tertiary500;
  // ─── Grey ──────────────────────────────────────────────
  static const Color white = Color(0xffFFFFFF);
  static const Color grey50 = Color(0xffFAFAFA);
  static const Color grey100 = Color(0xffF5F5F5);
  static const Color grey200 = Color(0xffE6E6E6);
  static const Color grey300 = Color(0xffB3B3B3);
  static const Color grey400 = Color(0xff999999);
  static const Color grey500 = Color(0xff666666);
  static const Color grey600 = Color(0xff4D4D4D);
  static const Color grey700 = Color(0xff333333);
  static const Color grey800 = Color(0xff1A1A1A);
  static const Color grey900 = Color(0xff0D0D0D);
  static const Color grey1000 = Color(0xff050505);
  static const Color black = Color(0xff000000);
  static const Color grey = grey500;
  // ─── Success ───────────────────────────────────────────
  static const Color success50 = Color(0xffE8FBEE);
  static const Color success100 = Color(0xffC6F6D5);
  static const Color success200 = Color(0xff9AE6B4);
  static const Color success300 = Color(0xff68D391);
  static const Color success400 = Color(0xff48BB78);
  static const Color success500 = Color(0xff38A169);
  static const Color success600 = Color(0xff2F855A);
  static const Color success700 = Color(0xff276749);
  static const Color success800 = Color(0xff22543D);
  static const Color success900 = Color(0xff1C4532);
  static const Color success = success500;

  // ─── Info ──────────────────────────────────────────────
  static const Color info100 = Color(0xffCBFEF7);
  static const Color info200 = Color(0xff98FEF7);
  static const Color info300 = Color(0xff65FBFD);
  static const Color info400 = Color(0xff3EEAFB);
  static const Color info500 = Color(0xff00D0F9);
  static const Color info600 = Color(0xff00A2D6);
  static const Color info700 = Color(0xff007AB3);
  static const Color info800 = Color(0xff005790);
  static const Color info900 = Color(0xff003F77);
  static const Color info = info500;
  // ─── Warning ───────────────────────────────────────────
  static const Color warning100 = Color(0xffFFFBEB);
  static const Color warning200 = Color(0xffFEF3C7);
  static const Color warning300 = Color(0xffFDE68A);
  static const Color warning400 = Color(0xffFBBF24);
  static const Color warning500 = Color(0xffF59E0B);
  static const Color warning600 = Color(0xffD97706);
  static const Color warning700 = Color(0xffB45309);
  static const Color warning800 = Color(0xff92400E);
  static const Color warning900 = Color(0xff78350F);
  static const Color warning = warning500;
  static const Color gold = Color(0xfffab700);
  // ─── Error ─────────────────────────────────────────────
  static const Color error100 = Color(0xffFEDDCB);
  static const Color error200 = Color(0xffFEB398);
  static const Color error300 = Color(0xffFE8065);
  static const Color error400 = Color(0xffFE503F);
  static const Color error500 = Color(0xffFE0000);
  static const Color error600 = Color(0xffDA0012);
  static const Color error700 = Color(0xffB6001F);
  static const Color error800 = Color(0xff930026);
  static const Color error900 = Color(0xff79002A);
  static const Color error = error500;

  // ─── Main Colors ───────────────────────────
  static const List<Color> mainColors = [
    primary,
    secondary,
    tertiary,
    warning,
    error,
    success,
  ];
  static const List<Color> mainDarkColors = [
    primary700,
    info700,
    warning700,
    error700,
    success700,
    grey700,
  ];
}
