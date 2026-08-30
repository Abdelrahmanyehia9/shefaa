import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

mixin FavoriteAnimationMixin<T extends StatefulWidget>
    on State<T>, SingleTickerProviderStateMixin<T> {
  late final AnimationController favoriteAnimController;
  late final Animation<double> favoriteScaleAnim;
  late final Animation<double> favoriteParticleAnim;
  static const _particleCount = 6;

  @override
  void initState() {
    super.initState();
    favoriteAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    favoriteScaleAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.7), weight: 30),
          TweenSequenceItem(tween: Tween(begin: 1.7, end: 0.75), weight: 30),
          TweenSequenceItem(tween: Tween(begin: 0.75, end: 1.0), weight: 40),
        ]).animate(
          CurvedAnimation(
            parent: favoriteAnimController,
            curve: Curves.easeInOut,
          ),
        );

    favoriteParticleAnim = CurvedAnimation(
      parent: favoriteAnimController,
      curve: Curves.easeInOut,
    );
  }

  void playFavoriteAnimation() => favoriteAnimController.forward(from: 0);

  List<Widget> buildParticles({
    required double iconSize,
    required double padding,
    required IconData icon,
    required List<Color> colors,
  }) {
    final distance = favoriteParticleAnim.value * iconSize * 1.3;
    final opacity = (1 - favoriteParticleAnim.value).clamp(0.0, 1.0);
    final center = padding + iconSize / 2;

    return List.generate(_particleCount, (i) {
      final angle = (i / _particleCount) * 2 * math.pi;

      return Positioned(
        left: center + math.cos(angle) * distance - 3,
        top: center + math.sin(angle) * distance - 3,
        child: Opacity(
          opacity: opacity,
          child: Icon(
            icon,
            size: UISizes.sp8,
            color: colors[i % colors.length],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    favoriteAnimController.dispose();
    super.dispose();
  }
}
