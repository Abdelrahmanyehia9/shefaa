import 'package:flutter/material.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class AppSliderDots extends StatelessWidget {
  final int total;
  final int currentIndex;
  final double? margin;
  final Color? selectedColor, unSelectedColor;
  final double Function(bool selected)? width;
  final double Function(bool selected)? height;
  const AppSliderDots({
    super.key,
    required this.total,
    required this.currentIndex,
    this.selectedColor,
    this.margin,
    this.width,
    this.height,
    this.unSelectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          margin: EdgeInsets.symmetric(horizontal: margin ?? UISizes.w4),
          width:
              width?.call(index == currentIndex) ??
              (currentIndex == index ? UISizes.sp24 : UISizes.sp12),
          height: height?.call(index == currentIndex) ?? UISizes.sp6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UISizes.r48),
            color: currentIndex == index
                ? selectedColor ?? context.colors.primary
                : unSelectedColor ?? context.colors.surfaceContainerLow,
          ),
        ),
      ),
    );
  }
}
