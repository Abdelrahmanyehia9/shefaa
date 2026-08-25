import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';

enum RibbonPosition { topStart, topEnd }

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
  final RibbonPosition position;

  const AppRibbon({
    super.key,
    required this.child,
    this.data,
    this.style,
    this.enabled = true,
    this.position = RibbonPosition.topEnd,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final color = data?.color ?? context.colors.primary;
    final gradient = data?.gradient;
    final customRibbon = data?.customRibbon;
    final text = data?.text;

    final isTopEnd = position == RibbonPosition.topEnd;

    return ClipRect(
      child: Stack(
        children: [
          child,

          if (enabled)
            Positioned.directional(
              top: 0,
              start: 0,
              end: 0,
              textDirection: Directionality.of(context),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final ribbonWidth = constraints.maxWidth.clamp(100.0, 320.0);

                  final isRightSide = isRtl ? !isTopEnd : isTopEnd;

                  return Align(
                    alignment: isTopEnd
                        ? AlignmentDirectional.topEnd
                        : AlignmentDirectional.topStart,
                    child: Transform.translate(
                      offset: Offset(
                        isRightSide ? ribbonWidth * 0.4 : -ribbonWidth * 0.4,
                        ribbonWidth * 0.05,
                      ),
                      child: Transform.rotate(
                        angle: isRightSide ? 0.75 : -0.75,
                        child: Container(
                          width: ribbonWidth,
                          height: ribbonWidth * 0.1,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: UISizes.w8),
                          decoration: BoxDecoration(
                            color: color,
                            gradient: gradient,
                          ),
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
