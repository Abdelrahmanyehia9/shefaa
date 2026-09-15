import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_checkbox.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_radio.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/range_input.dart';

/// Base class لأي فلتر. كل فلتر مسؤول عن بناء الـ widget بتاعه بنفسه
/// عشان نحافظ على الـ generic type T ومنقعش في مشكلة dynamic erasure.
sealed class FilterConfig<T> {
  final String title;
  final T value;

  const FilterConfig({required this.title, required this.value});

  String buildSubtitle();

  Widget buildContent(BuildContext context);
}

/// ---------- Multi Select ----------
class MultiSelectFilterConfig<T> extends FilterConfig<List<T>> {
  final List<T> options;
  final Widget Function(T option, bool isSelected) labelBuilder;
  final String Function(T option) optionLabelBuilder;
  final ValueChanged<List<T>> onChanged;
  final bool showSelectAll;
  final String Function(List<T> selected)? subtitleBuilder;

  const MultiSelectFilterConfig({
    required super.title,
    required super.value,
    required this.options,
    required this.labelBuilder,
    required this.optionLabelBuilder,
    required this.onChanged,
    this.showSelectAll = true,
    this.subtitleBuilder,
  });

  @override
  String buildSubtitle() {
    if (subtitleBuilder != null) {
      return subtitleBuilder!(value);
    }
    if (value.isEmpty) return "اختار التخصص";

    if (value.length == options.length) {
      return "الجميع";
    }
    return "";
  }

  @override
  Widget buildContent(BuildContext context) {
    return Wrap(
      spacing: UISizes.sp12,
      runSpacing: UISizes.sp12,

      children: [
        if (showSelectAll)
          AppIconText(
            expandedText: true,
            customIcon: AppCheckbox(
              borderColor: Colors.transparent,
              value: value.length == options.length,
              onChanged: (checked) =>
                  onChanged(checked == true ? List<T>.of(options) : <T>[]),
            ),
            text: "الجميع",
            textStyle: context.textTheme.labelMedium,
          ),
        ...options.map((option) {
          final selected = value.contains(option);
          return AppIconText(
            gap: UISizes.w8,
            expandedText: true,
            customIcon: AppCheckbox(
              borderColor: Colors.transparent,
              value: selected,
              onChanged: (checked) {
                final updated = List<T>.of(value);
                checked == true ? updated.add(option) : updated.remove(option);
                onChanged(updated);
              },
            ),
            customText: labelBuilder(option, selected),
            textStyle: context.textTheme.labelMedium,
          );
        }),
      ],
    );
  }
}

/// ---------- Radio (single select) ----------
class RadioFilterConfig<T> extends FilterConfig<T?> {
  final List<T> options;
  final Widget Function(T option) itemBuilder;
  final ValueChanged<T> onChanged;
  final String Function(T? selected)? subtitleBuilder;
  final String defaultSubtitle;

  const RadioFilterConfig({
    required super.title,
    required super.value,
    required this.options,
    required this.itemBuilder,
    required this.onChanged,
    this.subtitleBuilder,
    this.defaultSubtitle = "الافتراضي",
  });

  @override
  String buildSubtitle() {
    if (subtitleBuilder != null) return subtitleBuilder!(value);
    return defaultSubtitle;
  }

  @override
  Widget buildContent(BuildContext context) {
    return AppRadio<T>(
      useListTile: false,
      value: value,
      items: options,
      itemBuilder: itemBuilder,
      onChange: (T? val) {
        if (val != null) onChanged(val);
      },
    );
  }
}

/// ---------- Range (زي سعر الكشف) ----------
class RangeFilterConfig extends FilterConfig<RangeValues> {
  final RangeValues bounds;
  final ValueChanged<RangeValues> onChanged;
  final String Function(double value) unitLabelBuilder;

  const RangeFilterConfig({
    required super.title,
    required super.value,
    required this.bounds,
    required this.onChanged,
    required this.unitLabelBuilder,
  });

  @override
  String buildSubtitle() =>
      "من ${unitLabelBuilder(value.start)} حتى ${unitLabelBuilder(value.end)}";

  @override
  Widget buildContent(BuildContext context) {
    return RangeInput(
      range: bounds,
      value: value,
      onChanged: onChanged,
      type: RangeInputType.wheel,
    );
  }
}

/// ---------- Slider (زي المسافة) ----------
class SliderFilterConfig extends FilterConfig<double> {
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final String Function(double value) unitLabelBuilder;

  const SliderFilterConfig({
    required super.title,
    required super.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.unitLabelBuilder,
  });

  @override
  String buildSubtitle() => unitLabelBuilder(value);

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(unitLabelBuilder(min)),

            AppText(unitLabelBuilder(max)),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
          padding: EdgeInsets.zero,
          inactiveColor: context.colors.surfaceContainerLow,
        ),
      ],
    );
  }
}

/// ---------- Custom ----------
class CustomFilterConfig extends FilterConfig<Object?> {
  final Widget child;
  final String subtitle;

  const CustomFilterConfig({
    required super.title,
    required this.child,
    required this.subtitle,
  }) : super(value: null);

  @override
  String buildSubtitle() => subtitle;

  @override
  Widget buildContent(BuildContext context) => child;
}
