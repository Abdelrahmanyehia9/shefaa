import 'package:flutter/material.dart';
import 'package:shefaa/core/components/section_header.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String? Function(T?)? validator;
  final String Function(T)? itemLabelBuilder;
  final Widget Function(T)? itemBuilder;
  final Widget Function(T)? selectedItemBuilder;
  final TextStyle? style;
  final bool enabled;
  final EdgeInsets? padding;
  final AutovalidateMode autoValidateMode;
  final String? headerText;
  final bool? filled;
  final TextDirection? textDirection;
  final AlignmentGeometry alignment;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final Widget? suffix;
  final Widget? prefix;
  final Color? filledColor;
  final Color? borderColor;
  final double borderRadius;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedErrorBorder;
  final Widget? customHeader;
  final void Function(T?)? onChange;
  final void Function()? onTap;
  final double gapUnderHeader;
  final double? height;
  final double? menuMaxHeight;
  final Color? dropdownColor;
  final int? elevation;
  final Icon? icon;
  final Icon? disabledIcon;
  final bool isExpanded;
  final bool isDense;

  const AppDropdown({
    super.key,
    this.value,
    required this.items,
    this.validator,
    this.itemLabelBuilder,
    this.itemBuilder,
    this.selectedItemBuilder,
    this.style,
    this.enabled = true,
    this.padding,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.headerText,
    this.filled,
    this.textDirection,
    this.alignment = AlignmentDirectional.centerStart,
    this.helperText,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.suffix,
    this.prefix,
    this.filledColor,
    this.borderColor,
    this.borderRadius = 8,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.disabledBorder,
    this.focusedErrorBorder,
    this.customHeader,
    this.onChange,
    this.onTap,
    this.gapUnderHeader = 4,
    this.height,
    this.menuMaxHeight,
    this.dropdownColor,
    this.elevation,
    this.icon,
    this.disabledIcon,
    this.isExpanded = true,
    this.isDense = false,
  }) : assert(
         itemBuilder != null || itemLabelBuilder != null,
         'Either itemBuilder or itemLabelBuilder must be provided.',
       );

  InputBorder? _resolvedBorder(InputBorder? explicit, InputBorder? theme) {
    if (explicit != null) return explicit;
    if (borderColor != null) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor!),
      );
    }
    return theme;
  }

  @override
  Widget build(BuildContext context) {
    if (headerText != null || customHeader != null) {
      return Column(
        spacing: gapUnderHeader,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [?_header(context), _dropdown(context)],
      );
    }
    return _dropdown(context);
  }

  Widget _dropdown(BuildContext context) {
    final InputDecorationThemeData decoration = context.inputDecorationTheme;
    final Color hintColor =
        decoration.hintStyle?.color ?? Theme.of(context).hintColor;
    final Color labelColor =
        decoration.labelStyle?.color ?? Theme.of(context).hintColor;
    final Color helperColor =
        decoration.helperStyle?.color ?? Theme.of(context).hintColor;
    final TextStyle? resolvedHintStyle =
        hintStyle ?? context.textTheme.bodyMedium?.copyWith(color: hintColor);

    return SizedBox(
      height: height,

      child: DropdownButtonFormField<T>(
        initialValue: value,
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                alignment: alignment,
                child:
                    itemBuilder?.call(item) ??
                    Text(
                      itemLabelBuilder!(item),
                      style: style ?? context.textTheme.bodyMedium,
                    ),
              ),
            )
            .toList(),
        selectedItemBuilder: selectedItemBuilder != null
            ? (context) =>
                  items.map((item) => selectedItemBuilder!(item)).toList()
            : null,
        onChanged: enabled ? onChange : null,
        onTap: onTap,
        validator: validator,
        autovalidateMode: autoValidateMode,
        style: style ?? context.textTheme.bodyMedium,
        icon: icon,
        iconEnabledColor: disabledIcon?.color,
        iconDisabledColor: disabledIcon?.color,
        dropdownColor: dropdownColor,
        elevation: elevation ?? 8,
        isExpanded: isExpanded,
        isDense: isDense,
        alignment: alignment,
        menuMaxHeight: menuMaxHeight,

        borderRadius: BorderRadius.circular(borderRadius),
        decoration: InputDecoration(
          focusedBorder: _resolvedBorder(
            focusedBorder ?? border,
            decoration.focusedBorder,
          ),
          enabledBorder: _resolvedBorder(
            enabledBorder ?? border,
            decoration.enabledBorder,
          ),
          errorBorder: _resolvedBorder(
            errorBorder ?? border,
            decoration.errorBorder,
          ),
          focusedErrorBorder: _resolvedBorder(
            focusedErrorBorder ?? border,
            decoration.focusedErrorBorder,
          ),
          disabledBorder: _resolvedBorder(
            disabledBorder ?? border,
            decoration.disabledBorder,
          ),
          border: _resolvedBorder(border, decoration.border),
          filled: filled,
          fillColor: filledColor ?? decoration.fillColor,
          isDense: decoration.isDense,
          prefixIcon: prefix != null
              ? IconTheme(
                  data: IconThemeData(color: hintColor),
                  child: prefix!,
                )
              : null,
          suffixIcon: suffix != null
              ? IconTheme(
                  data: IconThemeData(color: hintColor),
                  child: suffix!,
                )
              : null,
          enabled: enabled,
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          labelStyle:
              labelStyle ??
              context.textTheme.bodyMedium?.copyWith(color: labelColor),
          hintStyle: resolvedHintStyle,
          helperStyle:
              helperStyle ??
              context.textTheme.bodyMedium?.copyWith(color: helperColor),
          errorStyle: errorStyle,
          contentPadding: padding,
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
}
