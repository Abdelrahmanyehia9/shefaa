import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_svg.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_assets.dart';

class AppLogo extends StatelessWidget {
  final double? size;
  final Color? color;
  const AppLogo({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.colors.primary;
    final size = this.size ?? UISizes.sp64;
    return AppSvg.asset(
      AppAssets.logo,
      width: size,
      height: size,
      color: color,
    );
  }
}
