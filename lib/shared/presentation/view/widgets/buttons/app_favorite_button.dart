import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class AppFavoriteButton extends StatelessWidget {
  final Color? color , bgColor;
  final double? size;
  const AppFavoriteButton({super.key, this.size, this.color, this.bgColor});

  @override
  Widget build(BuildContext context) {
    final color = this.color??AppColors.white ;
    final bgColor = this.bgColor ?? AppColors.white.veryLight ;
    final padding = UISizes.sp6  ;
    final iconSize =size?? UISizes.sp24;
    return CircleIconButton(
        backgroundColor: bgColor,
        padding: padding,
        iconColor: color,
        AppIcons.favorite,
      iconSize: iconSize,


    );
  }
}
