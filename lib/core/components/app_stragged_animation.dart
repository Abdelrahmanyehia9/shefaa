import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class AppStaggeredAnimation extends StatelessWidget {
  const AppStaggeredAnimation({
    super.key,
    required this.children,
    this.duration = const Duration(milliseconds: 400),
    this.delay = const Duration(milliseconds: 100),
    this.slideBegin = .3,
    this.spacing,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.curve = Curves.easeInOut,
  });

  final List<Widget> children;
  final Duration duration;
  final Duration delay;
  final double slideBegin;
  final double? spacing;
  final Curve curve;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final spacing = this.spacing ?? UISizes.h16;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      spacing: spacing,
      children: List.generate(children.length, (index) {
        final itemDelay = delay * index;

        return children[index]
            .animate()
            .fadeIn(duration: duration, delay: itemDelay)
            .slideY(
              begin: -slideBegin,
              end: 0,
              duration: duration,
              delay: itemDelay,
              curve: curve,
            );
      }),
    );
  }
}
