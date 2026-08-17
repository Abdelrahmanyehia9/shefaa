import 'package:flutter/material.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class AppSliderDots extends StatelessWidget {
  final int total;
  final int currentIndex;
  final Color? selectedColor, unSelectedColor;

  const AppSliderDots({
    super.key,
    required this.total,
    required this.currentIndex,
    this.selectedColor,
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
          margin: EdgeInsets.symmetric(horizontal: UISizes.w2),
          width: currentIndex == index ? UISizes.w24 : UISizes.w8,
          height: UISizes.h4,
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
