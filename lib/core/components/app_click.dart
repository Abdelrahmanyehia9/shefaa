import 'package:flutter/material.dart';

class AppClick extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap, onLongPress, onDoubleTap;
  final void Function(TapUpDetails)? onTapUp;
  final void Function(TapDownDetails)? onTapDown;

  final bool enabled;

  const AppClick({
    super.key,
    required this.child,
    this.enabled = true,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapUp,
    this.onTapDown,
  });

  @override
  State<AppClick> createState() => _AppClickState();
}

class _AppClickState extends State<AppClick> {
  double _scale = 1;

  void _press() {
    if (widget.onTap == null) return;
    if (widget.enabled) setState(() => _scale = .96);
  }

  void _release() {
    if (widget.onTap == null) return;
    if (widget.enabled) setState(() => _scale = 1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) {
        _press();
        widget.onTapDown?.call(details);
      },
      onTapUp: (details) {
        _release();
        widget.onTapUp?.call(details);
      },
      onTapCancel: () => _release(),
      onTap: widget.enabled ? widget.onTap : null,
      onDoubleTap: widget.enabled ? widget.onDoubleTap : null,
      onLongPress: widget.enabled ? widget.onLongPress : null,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
