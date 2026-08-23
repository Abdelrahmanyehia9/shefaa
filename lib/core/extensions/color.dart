import 'package:flutter/material.dart';

extension ColorExt on Color {
  Color lighten([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  Color darken([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  Color withAppOpacity(double opacity) {
    return withValues(alpha: opacity.clamp(0.0, 1.0));
  }

  Color get light => lighten(.14).withAppOpacity(0.2);
  Color get veryLight => lighten(.2).withAppOpacity(0.12);
  Color get softLight => lighten(0.2).withAppOpacity(0.7);
}
