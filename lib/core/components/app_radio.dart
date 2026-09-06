import 'package:flutter/material.dart';
import 'package:shefaa/core/components/section_header.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';

enum AppRadioDirection { vertical, horizontal }

class AppRadio<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T)? itemLabelBuilder;
  final Widget Function(T)? itemBuilder;
  final TextStyle? style;
  final bool enabled;
  final String? headerText;
  final Widget? customHeader;
  final void Function(T?)? onChange;
  final double gapUnderHeader;
  final double gapBetweenItems;
  final AppRadioDirection direction;
  final Color? activeColor;
  final Color? inactiveColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final EdgeInsetsGeometry? contentPadding;
  final bool useListTile;
  final ListTileControlAffinity controlAffinity;
  final String? errorText;
  final TextStyle? errorStyle;
  final WrapAlignment wrapAlignment;

  const AppRadio({
    super.key,
    this.value,
    required this.items,
    this.itemLabelBuilder,
    this.itemBuilder,
    this.style,
    this.enabled = true,
    this.headerText,
    this.customHeader,
    this.onChange,
    this.gapUnderHeader = 4,
    this.gapBetweenItems = 4,
    this.direction = AppRadioDirection.vertical,
    this.activeColor,
    this.inactiveColor,
    this.materialTapTargetSize,
    this.contentPadding,
    this.useListTile = true,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.errorText,
    this.errorStyle,
    this.wrapAlignment = WrapAlignment.start,
  }) : assert(
  itemBuilder != null || itemLabelBuilder != null,
  'Either itemBuilder or itemLabelBuilder must be provided.',
  );

  @override
  Widget build(BuildContext context) {
    if (headerText != null || customHeader != null) {
      return Column(
        spacing: gapUnderHeader,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [?_header(context), _radioGroup(context), ?_error(context)],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_radioGroup(context), ?_error(context)],
    );
  }

  Widget _radioGroup(BuildContext context) {
    final children = items.map((item) => _radioItem(context, item)).toList();

    final Widget group = direction == AppRadioDirection.vertical
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: gapBetweenItems,
      children: children,
    )
        : Wrap(
      spacing: gapBetweenItems * 4,
      runSpacing: gapBetweenItems,
      alignment: wrapAlignment,
      children: children,
    );

    return RadioGroup<T>(
      groupValue: value,
      // onChanged must be a non-nullable ValueChanged<T?>, so the
      // `enabled` check happens *inside* the callback instead of
      // swapping the callback itself for null.
      onChanged: (T? newValue) {
        if (enabled) onChange?.call(newValue);
      },
      child: enabled
          ? group
          : Opacity(
        opacity: 0.5,
        child: IgnorePointer(child: group),
      ),
    );
  }
  Widget _radioItem(BuildContext context, T item) {
    final label =
        itemBuilder?.call(item) ??
            Text(
              itemLabelBuilder!(item),
              style: style ?? context.textTheme.bodyMedium,
            );

    if (useListTile) {
      return RadioListTile<T>(
        value: item,
        title: label,
        activeColor: activeColor,
        controlAffinity: controlAffinity,
        contentPadding: contentPadding ?? EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize:
        materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
      );
    }

    return InkWell(
      onTap: enabled ? () => onChange?.call(item) : null,
      child: Padding(
        padding: contentPadding ?? EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<T>(
              value: item,
              activeColor: activeColor,
              fillColor: inactiveColor != null
                  ? WidgetStateProperty.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                    ? activeColor
                    : inactiveColor,
              )
                  : null,
              materialTapTargetSize:
              materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
            ),
            label,
          ],
        ),
      ),
    );
  }

  Widget? _header(BuildContext context) {
    if (customHeader != null) return customHeader;
    if (!headerText.isNullOrEmpty) {
      return SectionHeader.smallHeader(headerText!);
    }
    return null;
  }

  Widget? _error(BuildContext context) {
    if (errorText.isNullOrEmpty) return null;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        errorText!,
        style:
        errorStyle ??
            context.textTheme.bodySmall?.copyWith(color: context.colors.error),
      ),
    );
  }
}