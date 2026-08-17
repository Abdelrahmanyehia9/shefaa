import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeGradient,
    this.inactiveColor,
    this.activeColor,
    this.checkColor = Colors.white,
    this.borderColor,
    this.size = 22,
    this.borderRadius = 6,
    this.borderWidth = 1.5,
    this.duration = const Duration(milliseconds: 200),
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Gradient? activeGradient;
  final Color? inactiveColor, activeColor, borderColor;
  final Color checkColor;
  final double size;
  final double borderRadius;
  final double borderWidth;
  final Duration duration;

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox>
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
  void didUpdateWidget(covariant AppCheckbox oldWidget) {
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
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final t = _animation.value;
          return Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: t > 0 ? widget.activeGradient : null,
              color: t == 0
                  ? widget.inactiveColor ?? context.colors.surfaceContainerLow
                  : widget.activeColor ?? context.colors.primary,
              border: Border.all(
                color:
                    widget.borderColor ??
                    context.colors.outline.withAppOpacity(1 - t),
                width: widget.borderWidth,
              ),
            ),
            child: Opacity(
              opacity: t,
              child: Center(
                child: CustomPaint(
                  size: Size(widget.size * 0.55, widget.size * 0.55),
                  painter: _CheckPainter(color: widget.checkColor, progress: t),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  _CheckPainter({required this.color, required this.progress});

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final p1 = Offset(size.width * 0.0, size.height * 0.5);
    final p2 = Offset(size.width * 0.4, size.height * 0.9);
    final p3 = Offset(size.width * 1.0, size.height * 0.1);

    path.moveTo(p1.dx, p1.dy);
    path.lineTo(p2.dx, p2.dy);
    path.lineTo(p3.dx, p3.dy);

    final metrics = path.computeMetrics().first;
    final extractPath = metrics.extractPath(0, metrics.length * progress);

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant _CheckPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
