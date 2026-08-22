import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/components/app_click.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? color;
  final double? radius;
  final BlendMode? colorBlendMode;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? opacity;
  final bool enableViewer;
  final BoxBorder? border;

  final Alignment? alignment;

  const AppCachedNetworkImage(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.enableViewer = false,
    this.color,
    this.alignment,
    this.radius,
    this.colorBlendMode,
    this.placeholder,
    this.errorWidget,
    this.opacity,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNullOrEmpty) {
      return placeholder ?? _buildErrorWidget(context);
    }
    final image = AppClick(
      enabled: !imageUrl.isNullOrEmpty,
      onDoubleTap: enableViewer ? onView : null,
      child: Opacity(
        opacity: opacity ?? 1,
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: width ?? UISizes.w80,
          height: height ?? UISizes.h80,

          fit: fit,
          color: color,
          alignment: alignment ?? Alignment.center,
          colorBlendMode: colorBlendMode,
          memCacheWidth: 600,
          placeholder: (context, url) => _buildPlaceholder(context),
          errorWidget: (context, url, error) =>
              errorWidget ?? _buildErrorWidget(context),
        ),
      ),
    );

    Widget result = image;
    if (borderRadius != null || radius != null) {
      result = ClipRSuperellipse(
        borderRadius:
            borderRadius ?? BorderRadius.circular(radius ?? UISizes.r8),
        child: result,
      );
    }

    if (border != null) {
      result = DecoratedBox(
        decoration: BoxDecoration(
          border: border,
          borderRadius:
              borderRadius ?? BorderRadius.circular(radius ?? UISizes.r8),
        ),
        child: result,
      );
    }

    return result;
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: width ?? UISizes.w80,
      height: height ?? UISizes.h80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius:
            borderRadius ?? BorderRadius.circular(radius ?? UISizes.r8),
        border: border,
      ),
      child: Opacity(
        opacity: 0.5,
        child: CircularProgressIndicator(
          strokeWidth: UISizes.sp1,
          color: context.colors.surfaceContainer,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      width: width ?? UISizes.w80,
      height: height ?? UISizes.h80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius:
            borderRadius ?? BorderRadius.circular(radius ?? UISizes.r8),
        border: border,
      ),
      child: Icon(
        Icons.broken_image,
        color: context.colors.surfaceContainer,
        size: (width ?? UISizes.w80) * 0.2,
      ),
    );
  }

  void onView() {
    // Implement the logic to view the image in full screen or a viewer.
  }
}
