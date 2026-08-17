import 'package:flutter/material.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/components/app_text.dart';

class RibbonData {
  final String text;
  final Gradient? gradient;
  final Color? color;
  final Widget? customRibbon;

  const RibbonData({
    required this.text,
    this.gradient,
    this.color,
    this.customRibbon,
  });
}

class AppRibbon extends StatelessWidget {
  final Widget child;
  final TextStyle? style;
  final bool enabled;
  final RibbonData? data;

  const AppRibbon({
    super.key,
    required this.child,
    this.data,
    this.style,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final color = data?.color ?? context.colors.primary;
    final gradient = data?.gradient;
    final customRibbon = data?.customRibbon;
    final text = data?.text;
    return ClipRect(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          child,
          if (enabled)
            Positioned.directional(
              textDirection: Directionality.of(context),
              top: 0,
              end: 0,
              start: 0,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final ribbonWidth = (constraints.maxWidth.clamp(60.0, 180.0));
                  return Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Transform.translate(
                      offset: Offset(
                        isRtl ? -ribbonWidth * 0.375 : ribbonWidth * 0.375,
                        ribbonWidth * 0.065,
                      ),
                      child: Transform.rotate(
                        angle: isRtl ? -0.785 : 0.785,
                        child: Container(
                          width: ribbonWidth,
                          height: ribbonWidth * 0.1,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color,
                            gradient: gradient,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: UISizes.w8),
                          child:
                              customRibbon ??
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: AppText(
                                  text,
                                  textAlign: TextAlign.center,
                                  style:
                                      style ??
                                      context.textTheme.labelSmall?.copyWith(
                                        color: AppColors.white,
                                      ),
                                ),
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
