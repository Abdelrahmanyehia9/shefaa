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

  Color get veryLight => lighten().withAppOpacity(0.1);
}
