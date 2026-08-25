import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';

class CircleChip extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double padding;
  const CircleChip({
    super.key,
    this.padding = 14,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppChip(
      paddingHr: padding,
      paddingVr: padding,
      shape: BoxShape.circle,
      color: color,
      monochromatic: true,
      child: child,
    );
  }
}
