import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gap extends StatelessWidget {
  final double size;
  final Axis? axis;
  const Gap(this.size, {super.key, this.axis});

  factory Gap.medium() => const Gap(16);
  factory Gap.small() => const Gap(8);
  factory Gap.extraSmall() => const Gap(4);
  factory Gap.large() => const Gap(24);
  factory Gap.extraLarge() => const Gap(32);
  factory Gap.huge() => const Gap(40);
  factory Gap.tiny() => const Gap(2);

  @override
  Widget build(BuildContext context) {
    Axis? axis = this.axis;
    if (axis == null) {
      context.visitAncestorElements((element) {
        final widget = element.widget;
        if (widget is Flex) {
          axis = widget.direction;
          return false;
        }
        return true;
      });
    }
    if (axis == Axis.horizontal) {
      return SizedBox(width: size.w);
    } else {
      return SizedBox(height: size.h);
    }
  }
}

class HGap extends StatelessWidget {
  final double size;
  const HGap(this.size, {super.key});

  factory HGap.medium() => const HGap(16);
  factory HGap.small() => const HGap(8);
  factory HGap.extraSmall() => const HGap(4);
  factory HGap.large() => const HGap(24);
  factory HGap.extraLarge() => const HGap(32);
  factory HGap.huge() => const HGap(40);
  factory HGap.tiny() => const HGap(2);

  @override
  Widget build(BuildContext context) {
    return Gap(size, axis: Axis.horizontal);
  }
}

class VGap extends StatelessWidget {
  final double size;
  const VGap(this.size, {super.key});

  factory VGap.medium() => const VGap(16);
  factory VGap.small() => const VGap(8);
  factory VGap.extraSmall() => const VGap(4);
  factory VGap.large() => const VGap(24);
  factory VGap.extraLarge() => const VGap(32);
  factory VGap.huge() => const VGap(40);
  factory VGap.tiny() => const VGap(2);

  @override
  Widget build(BuildContext context) {
    return Gap(size, axis: Axis.vertical);
  }
}
