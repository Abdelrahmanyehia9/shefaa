import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_constants.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/amount_field.dart';

class BookingSupportUs extends StatefulWidget {
  const BookingSupportUs({super.key, this.onChanged});

  final ValueChanged<int?>? onChanged;

  @override
  State<BookingSupportUs> createState() => _BookingSupportUsState();
}

class _BookingSupportUsState extends State<BookingSupportUs> {
  static const _custom = -1;
  final _selected = ValueNotifier<int?>(null);
  final _controller = TextEditingController();

  void _select(int index) {
    final value = _selected.value == index ? null : index;
    _selected.value = value;

    widget.onChanged?.call(
      value == null
          ? null
          : value == _custom
          ? int.tryParse(_controller.text)
          : AppConstants.supportPay[value],
    );
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ValueListenableBuilder(
        valueListenable: _selected,
        builder: (_, selected, _) => SectionHeader(
          title: "قم بدعمنا",
          paddingVr: 0,
          action: selected != null ? "إلغاء الدعم" : null,
          onAction: selected != null ? () => _select(selected) : null,
        ),
      ),
      AppText(
        "دعمك لنا يساعدنا في تقديم خدمات بشكل أفضل",
        style: context.textTheme.bodyMedium,
        color: context.colors.surfaceContainer,
      ),
      Gap.medium(),
      ValueListenableBuilder(
        valueListenable: _selected,
        builder: (_, selected, _) => Column(
          spacing: UISizes.h16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: UISizes.sp4,
              runSpacing: UISizes.sp4,
              children: [
                ...AppConstants.supportPay.indexed.map(
                  (e) =>
                      _chip("${e.$2.toStringAsFixed(1)} ج.م", e.$1, selected),
                ),
                _chip("مبلغ آخر", _custom, selected),
              ],
            ),
            AmountField(
                  controller: _controller,
                  min: 1,
                  max: 1000,
                  onChanged: selected == _custom
                      ? (value) =>
                            widget.onChanged?.call(int.tryParse(value ?? ""))
                      : null,
                )
                .animate(target: selected == _custom ? 1 : 0)
                .fadeIn(duration: 250.ms)
                .slideY(begin: -.2, end: 0, duration: 250.ms)
                .scaleY(
                  begin: 0,
                  end: 1,
                  alignment: Alignment.topCenter,
                  duration: 250.ms,
                  curve: Curves.easeOut,
                ),
          ],
        ),
      ),
    ],
  );

  Widget _chip(String text, int index, int? selected) {
    final isSelected = index == selected;
    return AppChip(
      title: text,
      radius: UISizes.sp8,
      paddingHr: UISizes.w24,
      color: isSelected ? context.colors.primary : Colors.transparent,
      titleStyle: context.textTheme.labelMedium,
      titleColor: isSelected
          ? context.colors.onPrimary
          : context.colors.surfaceContainer,
      borderColor: isSelected ? null : context.colors.surfaceContainerLow,
      onTap: () => _select(index),
    );
  }

  @override
  void dispose() {
    _selected.dispose();
    _controller.dispose();
    super.dispose();
  }
}
