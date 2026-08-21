import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_assets.dart';

class AppLoader extends StatelessWidget {
  final double? size;
  final bool loop;
  final Color? backgroundColor ;
  const AppLoader({super.key,this.backgroundColor ,this.size, this.loop = true});

  @override
  Widget build(BuildContext context) {
    final double size = this.size ?? UISizes.sp128;
   final backgroundColor = this.backgroundColor ?? context.colors.surface ;
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadiusGeometry.circular(UISizes.r16),
         
        ),
        child: Transform.scale(
          scale: 1.2,
          child: Lottie.asset(
            repeat: loop,
            width: size,
            height: size,
            fit: BoxFit.cover,
            AppAssets.logoAnimated,
          ),
        ),
      ),
    );
  }
}
