import 'package:flutter/material.dart';

import 'package:shefaa/core/extensions/theme.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeGradient,
    this.inactiveColor,
    this.activeColor,
    this.thumbColor = Colors.white,
    this.width = 52,
    this.height = 30,
    this.thumbPadding = 3,
    this.duration = const Duration(milliseconds: 200),
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Gradient? activeGradient;
  final Color? inactiveColor, activeColor;
  final Color thumbColor;
  final double width;
  final double height;
  final double thumbPadding;
  final Duration duration;

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.value ? 1 : 0,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(covariant AppSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onChanged(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final thumbSize = widget.height - (widget.thumbPadding * 2);
    final travel = widget.width - widget.height;
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final t = _animation.value;
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.height / 2),
              gradient: t > 0 ? widget.activeGradient : null,
              color: t == 0
                  ? widget.inactiveColor ?? context.colors.surfaceContainerLow
                  : widget.activeColor ?? context.colors.primary,
            ),
            child: Stack(
              children: [
                Positioned(
                  left: widget.thumbPadding + (travel * t),
                  top: widget.thumbPadding,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.thumbColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
