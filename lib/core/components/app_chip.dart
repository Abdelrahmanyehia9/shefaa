import 'package:flutter/material.dart';

import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';

class AppChip extends StatelessWidget {
  // ===== Sizing =====
  final double? height,
      maxWidth,
      minWidth,
      maxHeight,
      minHeight,
      width,
      radius,
      borderWidth,
      paddingHr,
      paddingVr,
      marginHr,
      marginVr,
      spacing; // gap between leading/trailing and title

  // ===== Colors =====
  final Color? borderColor, titleColor, color;
  final Gradient? gradient; // takes priority over `color` if provided
  final List<BoxShadow>? boxShadow;

  // ===== Shape / layout =====
  final BoxShape shape;
  final Clip? clipBehavior;
  final AlignmentGeometry? alignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  // ===== Content =====
  final String? title;
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  // ===== Behavior =====
  final bool monochromatic;
  final bool enabled;
  final double disabledOpacity;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Duration animationDuration;
  final Curve animationCurve;

  const AppChip({
    super.key,
    this.height,
    this.width,
    this.monochromatic = false,
    this.title,
    this.child,
    this.leading,
    this.trailing,
    this.titleStyle,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.color,
    this.gradient,
    this.boxShadow,
    this.borderColor,
    this.borderWidth,
    this.titleColor,
    this.shape = BoxShape.rectangle,
    this.clipBehavior,
    this.radius,
    this.paddingHr,
    this.paddingVr,
    this.marginHr,
    this.marginVr,
    this.spacing,
    this.maxWidth,
    this.minWidth,
    this.maxHeight,
    this.minHeight,
    this.enabled = true,
    this.disabledOpacity = 0.5,
    this.onTap,
    this.onLongPress,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? context.primaryColor;

    // BoxShape.circle in Flutter throws if borderRadius is also set,
    // so we only apply radius when the shape is a rectangle.
    final effectiveRadius = shape == BoxShape.circle
        ? null
        : BorderRadius.circular(radius ?? UISizes.r12);

    final content =
        child ??
        Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: [
            if (leading != null) ...[
              leading!,
              SizedBox(width: spacing ?? UISizes.w4),
            ],
            Flexible(
              child: AppText(
                title,
                textAlign: textAlign,
                maxLines: maxLines,
                overflow: overflow,
                style: (titleStyle ?? TextStyle(fontFamily: fontFamily))
                    .copyWith(
                      color: monochromatic
                          ? baseColor
                          : titleColor ?? context.colors.onPrimary,
                      fontSize: fontSize ?? titleStyle?.fontSize,
                      fontWeight: fontWeight ?? titleStyle?.fontWeight,
                      fontFamily: fontFamily ?? titleStyle?.fontFamily,
                    ),
              ),
            ),
            if (trailing != null) ...[HGap(spacing ?? UISizes.w4), trailing!],
          ],
        );

    Widget chip = Container(
      width: width,
      height: height,
      alignment: alignment,
      padding: EdgeInsets.symmetric(
        horizontal: paddingHr ?? UISizes.w8,
        vertical: paddingVr ?? UISizes.h4,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: marginHr ?? 0,
        vertical: marginVr ?? 0,
      ),
      decoration: BoxDecoration(
        borderRadius: effectiveRadius,
        color: gradient == null
            ? (monochromatic ? baseColor.veryLight : baseColor)
            : null,
        gradient: gradient,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1,
        ),
        boxShadow: boxShadow,
        shape: shape,
      ),
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? double.infinity,
        minWidth: minWidth ?? 0,
        maxHeight: maxHeight ?? double.infinity,
        minHeight: minHeight ?? 0,
      ),
      child: content,
    );

    // Wrap with tap handling only when needed, keeping ripple clipped
    // to the same shape/radius as the chip itself.
    if (onTap != null || onLongPress != null) {
      chip = Material(
        color: Colors.transparent,
        shape: shape == BoxShape.circle
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: effectiveRadius ?? BorderRadius.zero,
              ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onTap : null,
          onLongPress: enabled ? onLongPress : null,
          customBorder: shape == BoxShape.circle
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: effectiveRadius ?? BorderRadius.zero,
                ),
          child: chip,
        ),
      );
    }

    if (!enabled) {
      chip = Opacity(
        opacity: disabledOpacity,
        child: IgnorePointer(child: chip),
      );
    }

    return chip;
  }
}
