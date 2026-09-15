import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/theme.dart';

enum RangeInputType { textField, wheel }

class RangeInput extends StatefulWidget {
  final String? header;
  final RangeInputType type;

  final RangeValues range;
  final RangeValues value;

  final ValueChanged<RangeValues> onChanged;

  const RangeInput({
    super.key,
    this.header,
    this.type = RangeInputType.textField,
    required this.range,
    required this.value,
    required this.onChanged,
  });

  @override
  State<RangeInput> createState() => _RangeInputState();
}

class _RangeInputState extends State<RangeInput> {
  late final TextEditingController _fromController;
  late final TextEditingController _toController;

  bool _isSyncing = false;

  double get min => widget.range.start;
  double get max => widget.range.end;

  @override
  void initState() {
    super.initState();

    _fromController = TextEditingController(
      text: widget.value.start.toStringAsFixed(0),
    );

    _toController = TextEditingController(
      text: widget.value.end.toStringAsFixed(0),
    );

    _setupControllers();
  }

  @override
  void didUpdateWidget(covariant RangeInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _syncControllersWithValue(widget.value);
    }
  }

  void _setupControllers() {
    _fromController.addListener(_onFromChanged);
    _toController.addListener(_onToChanged);
  }

  void _onFromChanged() {
    if (_isSyncing) return;

    final parsed = double.tryParse(_fromController.text);
    if (parsed == null) return;

    final newStart = parsed.clamp(min, widget.value.end);

    if (newStart != widget.value.start) {
      widget.onChanged(RangeValues(newStart, widget.value.end));
    }
  }

  void _onToChanged() {
    if (_isSyncing) return;

    final parsed = double.tryParse(_toController.text);
    if (parsed == null) return;

    final newEnd = parsed.clamp(widget.value.start, max);

    if (newEnd != widget.value.end) {
      widget.onChanged(RangeValues(widget.value.start, newEnd));
    }
  }

  void _syncControllersWithValue(RangeValues value) {
    final start = value.start.toStringAsFixed(0);
    final end = value.end.toStringAsFixed(0);

    _isSyncing = true;

    if (_fromController.text != start) {
      _fromController.value = TextEditingValue(
        text: start,
        selection: TextSelection.collapsed(offset: start.length),
      );
    }

    if (_toController.text != end) {
      _toController.value = TextEditingValue(
        text: end,
        selection: TextSelection.collapsed(offset: end.length),
      );
    }

    _isSyncing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.header != null)
          Text(widget.header!, style: context.textTheme.labelMedium),
        if (widget.type == RangeInputType.wheel)
          RangeSliderWidget(
            min: min,
            max: max,
            value: widget.value,
            onChanged: widget.onChanged,
          ),
        Gap.tiny(),
        Row(
          spacing: 12.w,
          children: [
            _field(hint: "من", controller: _fromController),
            _field(hint: "الى", controller: _toController),
          ],
        ),
      ],
    );
  }

  Widget _field({
    required String hint,
    required TextEditingController controller,
  }) {
    return Expanded(
      child: AppTextField(
        hintText: hint,
        controller: controller,
        padding: EdgeInsets.zero,
        keyboardType: TextInputType.number,
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          MaxValueFormatter(max),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fromController.removeListener(_onFromChanged);
    _toController.removeListener(_onToChanged);

    _fromController.dispose();
    _toController.dispose();

    super.dispose();
  }
}

class MaxValueFormatter extends TextInputFormatter {
  final double max;

  MaxValueFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = double.tryParse(newValue.text);

    if (value == null || value > max) {
      return oldValue;
    }

    return newValue;
  }
}

class RangeSliderWidget extends StatefulWidget {
  final double min;
  final double max;
  final RangeValues value;
  final ValueChanged<RangeValues> onChanged;

  const RangeSliderWidget({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  final List<double> _bars = List.generate(
    30,
    (_) => 0.15 + Random().nextDouble() * 0.85,
  );

  _ActiveThumb? _activeThumb;

  double get _total => widget.max - widget.min;

  double _toValue(double x, double width, TextDirection direction) {
    final fraction = (x / width).clamp(0.0, 1.0);

    final adjustedFraction = direction == TextDirection.rtl
        ? 1 - fraction
        : fraction;

    return (adjustedFraction * _total + widget.min).clamp(
      widget.min,
      widget.max,
    );
  }

  double _toX(double value, double width, TextDirection direction) {
    final fraction = (value - widget.min) / _total;

    return direction == TextDirection.rtl
        ? (1 - fraction) * width
        : fraction * width;
  }

  void _onStart(double x, double width, TextDirection direction) {
    final range = widget.value;

    final startX = _toX(range.start, width, direction);

    final endX = _toX(range.end, width, direction);

    _activeThumb = (x - startX).abs() <= (x - endX).abs()
        ? _ActiveThumb.start
        : _ActiveThumb.end;

    _moveTo(x, width, direction);
  }

  void _moveTo(double x, double width, TextDirection direction) {
    final value = _toValue(x, width, direction);

    final range = widget.value;

    final updated = _activeThumb == _ActiveThumb.start
        ? RangeValues(value.clamp(widget.min, range.end - 1), range.end)
        : RangeValues(range.start, value.clamp(range.start, widget.max));

    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final direction = Directionality.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final range = widget.value;

        final startFraction = (range.start - widget.min) / _total;

        final endFraction = (range.end - widget.min) / _total;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,

          onTapDown: (details) {
            _onStart(details.localPosition.dx, width, direction);
          },

          onHorizontalDragStart: (details) {
            _onStart(details.localPosition.dx, width, direction);
          },

          onHorizontalDragUpdate: (details) {
            _moveTo(details.localPosition.dx, width, direction);
          },

          onHorizontalDragEnd: (_) {
            _activeThumb = null;
          },

          child: SizedBox(
            height: 50,
            width: width,
            child: CustomPaint(
              painter: _BarsPainter(
                bars: _bars,
                startFraction: startFraction,
                endFraction: endFraction,
                activeColor: context.colors.primary,
                inactiveColor: context.colors.surfaceContainer,
                textDirection: direction,
              ),
            ),
          ),
        );
      },
    );
  }
}

enum _ActiveThumb { start, end }

class _BarsPainter extends CustomPainter {
  final List<double> bars;
  final double startFraction;
  final double endFraction;
  final Color activeColor;
  final Color inactiveColor;
  final TextDirection textDirection;

  const _BarsPainter({
    required this.bars,
    required this.startFraction,
    required this.endFraction,
    required this.activeColor,
    required this.inactiveColor,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final count = bars.length;
    final step = size.width / count;
    final barW = step * 0.5;

    for (int i = 0; i < count; i++) {
      final fraction = i / count;

      final isActive = fraction >= startFraction && fraction < endFraction;

      final barH = bars[i] * size.height;

      final left = textDirection == TextDirection.rtl
          ? size.width - ((i + 1) * step) + (step - barW) / 2
          : i * step + (step - barW) / 2;

      final top = size.height - barH;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, barW, barH),
          const Radius.circular(2),
        ),
        Paint()..color = isActive ? activeColor : inactiveColor,
      );
    }
  }

  @override
  bool shouldRepaint(_BarsPainter old) {
    return old.startFraction != startFraction ||
        old.endFraction != endFraction ||
        old.textDirection != textDirection;
  }
}
