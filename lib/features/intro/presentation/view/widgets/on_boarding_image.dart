import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class OnBoardingImage extends StatelessWidget {
  final Color? color;
  final String image;
  final bool showRibbon ;

  const OnBoardingImage(this.image,  {super.key, this.color,this.showRibbon = false,});

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.colors.primary;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        if(showRibbon)
        _buildRibbon(color),
        _OnBoardingArchShape(imagePath: image, color: color),
      ],
    );
  }

  Widget _buildRibbon(Color color) => Builder(
    builder: (context) => Positioned(
      left: -UISizes.sp96,
      right: -UISizes.sp96,
      child: Transform.rotate(
        angle: -0.25,
        child: Container(
          height: UISizes.sp156,
          width: double.infinity,
          color: color,
        ),
      ),
    ).animate(
    ).scale(
      duration: 500.ms,
      begin: const Offset(0,1),
        end: const Offset(1, 1)
    )
  );
}

class _OnBoardingArchShape extends StatelessWidget {
  final String imagePath;
  final Color color;

  const _OnBoardingArchShape({required this.color, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final height = UISizes.sp320;
    final radius = UISizes.sp110;
    final width = UISizes.sp256;
    final borderWidth = UISizes.sp14;
    final archRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius * .1),
      bottomRight: Radius.circular(radius * .1),
    );
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: context.scaffoldBackgroundColor,
              width: borderWidth,
            ),
            borderRadius: archRadius,
            boxShadow: [
              BoxShadow(
                color: color.withAppOpacity(0.5),
                blurRadius: UISizes.sp16,
                offset: Offset(0, UISizes.sp4),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.only(bottom: UISizes.sp14),
          child: Image.asset(
            imagePath,
            width: width - (borderWidth * 2),
            height: height + (borderWidth * 1.5),
            fit: BoxFit.fitHeight,
          ),
        )
      ],
    );
  }
}
