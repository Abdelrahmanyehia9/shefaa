import 'package:flutter/material.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/utils/text_styles.dart';

enum ButtonType { filled, outlined, text }

class AppButton extends StatelessWidget {
  final Widget? child;
  final ButtonType buttonType;
  final Color? color;
  final Color? disabledColor;
  final Color? borderColor;
  final Color? disabledBorderColor;
  final Color? loadingColor;
  final bool isDisabled;
  final bool isLoading;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final Size? fixedSize;
  final Gradient? gradient;
  final double? borderRadius;
  final double borderWidth;
  final double loadingStrokeWidth;
  final double? loadingSize;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxShape shape;
  final AlignmentGeometry? alignment;

  const AppButton({
    super.key,
    this.child,
    this.buttonType = ButtonType.filled,
    this.color,
    this.disabledColor,
    this.borderColor,
    this.disabledBorderColor,
    this.loadingColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.alignment = AlignmentGeometry.center,
    this.shape = BoxShape.rectangle,
    this.gradient,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.fixedSize,
    this.borderRadius,
    this.borderWidth = 1.0,
    this.loadingStrokeWidth = 2.0,
    this.loadingSize,
    this.padding,
    this.margin,
  });

  factory AppButton.text(
    String text, {
    TextStyle? style,
    Color? textColor,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    AlignmentGeometry? align,
    bool isDisabled = false,
    bool isLoading = false,
    Color? loadingColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) => AppButton(
    buttonType: ButtonType.text,
    color: textColor,
    onTap: onTap,
    alignment: align ?? AlignmentGeometry.topStart,
    onLongPress: onLongPress,
    onDoubleTap: onDoubleTap,
    isDisabled: isDisabled,
    isLoading: isLoading,
    loadingColor: loadingColor,
    padding: padding,
    margin: margin,
    child: Text(
      text,
      style: style?.copyWith(color: textColor) ?? TextStyle(color: textColor),
    ),
  );

  factory AppButton.filled(
    String text, {
    TextStyle? style,
    Color? backgroundColor,
    bool isDisabled = false,
    Size fixedSize = const Size(double.infinity, 50),
    Color? textColor,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    bool isLoading = false,
    Color? loadingColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) => AppButton(
    color: backgroundColor,
    onTap: onTap,
    onLongPress: onLongPress,
    onDoubleTap: onDoubleTap,
    fixedSize: fixedSize,
    isLoading: isLoading,
    isDisabled: isDisabled,
    loadingColor: loadingColor,
    padding: padding,
    margin: margin,
    child: Text(
      text,
      style:
          style?.copyWith(color: textColor ?? Colors.white) ??
          TextStyles.labelLarge.copyWith(color: textColor ?? Colors.white),
    ),
  );

  factory AppButton.gradient(
    String text, {
    required Gradient gradient,
    TextStyle? style,
    Widget? child,
    double? radius,
    bool isDisabled = false,
    Size fixedSize = const Size(double.infinity, 45),
    Color? textColor,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    bool isLoading = false,
    Color? loadingColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) => AppButton(
    onTap: onTap,
    gradient: gradient,
    onLongPress: onLongPress,
    onDoubleTap: onDoubleTap,
    fixedSize: fixedSize,
    isLoading: isLoading,
    isDisabled: isDisabled,
    loadingColor: loadingColor,
    borderRadius: radius,
    padding: padding,
    margin: margin,
    child:
        child ??
        Text(
          text,
          style:
              style?.copyWith(color: textColor ?? Colors.white) ??
              TextStyle(color: textColor ?? Colors.white),
        ),
  );

  factory AppButton.outlined(
    String text, {
    required Color color,
    TextStyle? style,
    bool isDisabled = false,
    Size fixedSize = const Size(double.infinity, 45),
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    bool isLoading = false,
    Color? loadingColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) => AppButton(
    buttonType: ButtonType.outlined,
    onTap: onTap,
    onLongPress: onLongPress,
    onDoubleTap: onDoubleTap,
    fixedSize: fixedSize,
    isLoading: isLoading,
    isDisabled: isDisabled,
    loadingColor: loadingColor ?? color,
    borderColor: color,
    padding: padding,
    margin: margin,
    child: Text(
      text,
      style: style?.copyWith(color: color) ?? TextStyle(color: color),
    ),
  );

  bool get isClickable => !isDisabled && !isLoading;

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: isClickable ? onTap : null,
      onDoubleTap: isClickable ? onDoubleTap : null,
      onLongPress: isClickable ? onLongPress : null,
      child: Container(
        alignment: alignment,
        width: fixedSize?.width,
        height: fixedSize?.height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          shape: shape,
          gradient: isDisabled ? null : gradient,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(borderRadius ?? 16),
          color: isDisabled
              ? _resolvedDisabledColor(context)
              : _resolvedColor(context),
          border: Border.all(
            color: isDisabled
                ? _resolvedDisabledBorderColor(context)
                : (borderColor ?? Colors.transparent),
            width: borderWidth,
          ),
        ),
        child: isLoading ? _buildLoading(context) : child,
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    final double size =
        loadingSize ??
        (fixedSize?.height != null ? fixedSize!.height * 0.5 : 20);
    final Color spinnerColor = loadingColor ?? _defaultLoadingColor(context);

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: loadingStrokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
      ),
    );
  }

  Color _defaultLoadingColor(BuildContext context) {
    switch (buttonType) {
      case ButtonType.filled:
        return Colors.white;
      case ButtonType.outlined:
        return borderColor ?? context.primaryColor;
      case ButtonType.text:
        return color ?? context.primaryColor;
    }
  }

  Color _resolvedColor(BuildContext context) => buttonType == ButtonType.filled
      ? (color ?? context.primaryColor)
      : Colors.transparent;

  Color _resolvedDisabledColor(BuildContext context) =>
      disabledColor ?? Theme.of(context).disabledColor;

  Color _resolvedDisabledBorderColor(BuildContext context) {
    if (buttonType != ButtonType.outlined) return Colors.transparent;
    return disabledBorderColor ?? Theme.of(context).disabledColor;
  }
}
