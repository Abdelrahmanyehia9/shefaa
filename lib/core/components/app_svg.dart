import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum _SvgSource { asset, network }

class AppSvg extends StatelessWidget {
  final String path;
  final _SvgSource _svgSource;
  final Color? color;
  final BlendMode colorBlendMode;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final WidgetBuilder? placeholderBuilder;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final Clip clipBehavior;
  final Map<String, String>? headers; // بيتستخدم في network بس

  const AppSvg._({
    super.key,
    required this.path,
    required this._svgSource,
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.headers,
  });

  factory AppSvg.asset(
    String path, {
    Key? key,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool matchTextDirection = false,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return AppSvg._(
      key: key,
      path: path,
      svgSource: _SvgSource.asset,
      color: color,
      colorBlendMode: colorBlendMode,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      matchTextDirection: matchTextDirection,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  factory AppSvg.network(
    String url, {
    Key? key,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool matchTextDirection = false,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    Map<String, String>? headers,
  }) {
    return AppSvg._(
      key: key,
      path: url,
      svgSource: _SvgSource.network,
      color: color,
      colorBlendMode: colorBlendMode,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      matchTextDirection: matchTextDirection,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      headers: headers,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorFilter = color != null
        ? ColorFilter.mode(color!, colorBlendMode)
        : null;

    switch (_svgSource) {
      case _SvgSource.asset:
        return SvgPicture.asset(
          path,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          colorFilter: colorFilter,
          matchTextDirection: matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder,
          semanticsLabel: semanticsLabel,
          excludeFromSemantics: excludeFromSemantics,
          clipBehavior: clipBehavior,
        );
      case _SvgSource.network:
        return SvgPicture.network(
          path,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          colorFilter: colorFilter,
          matchTextDirection: matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder,
          semanticsLabel: semanticsLabel,
          excludeFromSemantics: excludeFromSemantics,
          clipBehavior: clipBehavior,
          headers: headers,
        );
    }
  }
}
