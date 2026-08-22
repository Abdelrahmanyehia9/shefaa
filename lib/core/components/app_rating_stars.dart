import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';

///generated from ai
class AppRatingStars extends StatefulWidget {
  final double size;
  final bool readOnly;
  final String? title;
  final double spacing;
  final double rating;
  final ValueChanged<double>? onRatingChanged;

  const AppRatingStars({
    super.key,
    this.size = 16,
    this.spacing = 0,
    this.readOnly = true,
    this.title,
    this.rating = 0,
    this.onRatingChanged,
  }) : assert(
  readOnly || onRatingChanged != null,
  'onRatingChanged is required when readOnly is false',
  );

  @override
  State<AppRatingStars> createState() => _AppRatingStarsState();
}

class _AppRatingStarsState extends State<AppRatingStars> with TickerProviderStateMixin {
  late final ValueNotifier<double> _ratingNotifier;
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _ratingNotifier = ValueNotifier(widget.rating);

    _controllers = List.generate(
      5,
          (i) => AnimationController(vsync: this, duration: const Duration(milliseconds: 200)),
    );

    _scaleAnimations = _controllers.map((c) {
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
        TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
      ]).animate(CurvedAnimation(parent: c, curve: Curves.easeOut));
    }).toList();
  }

  @override
  void didUpdateWidget(AppRatingStars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating) {
      _ratingNotifier.value = widget.rating;
    }
  }

  @override
  void dispose() {
    _ratingNotifier.dispose();
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateRating(double newRating, int starIndex) {
    _ratingNotifier.value = newRating;
    widget.onRatingChanged!(newRating);
    for (int i = 0; i <= starIndex; i++) {
      Future.delayed(Duration(milliseconds: i * 40), () {
        if (mounted) _controllers[i].forward(from: 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) SectionHeader(title: widget.title!),
        ValueListenableBuilder<double>(
          valueListenable: _ratingNotifier,
          builder: (context, currentRating, _) {
            return Row(
              spacing: widget.spacing,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (i) => _buildStar(i, currentRating, context)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStar(int i, double currentRating, BuildContext context) {
    final full = i < currentRating.floor();
    final half = !full && i < currentRating && (currentRating - currentRating.floor()) >= 0.5;

    final icon = Icon(
      full ? AppIcons.starFilled : half ? AppIcons.starHalf : AppIcons.star,
      size: widget.size.sp,
      color: full || half ? AppColors.gold : context.colors.surfaceContainer,
    );

    if (widget.readOnly) return icon;

    return AppClick(
      onTap: () => _updateRating(i + 1.0, i),
      child: AnimatedBuilder(
        animation: _scaleAnimations[i],
        builder: (_, _) => Transform.scale(scale: _scaleAnimations[i].value, child: icon),
      ),
    );
  }
}