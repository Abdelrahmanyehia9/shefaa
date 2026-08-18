import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shefaa/core/components/section_header.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final bool autofocus;
  final TextAlign textAlign;
  final bool readOnly;
  final bool? showCursor;
  final bool enabled;
  final EdgeInsets? padding;
  final AutovalidateMode autoValidateMode;
  final String obscuringCharacter;
  final bool obscureText;
  final bool unfocusOnTapOutside;
  final bool autocorrect;
  final String? headerText;
  final bool? filled;
  final TextDirection? textDirection;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final int? minLines;
  final bool expands;
  final bool canRequestFocus;
  final TextStyle? headerStyle;
  final double gapUnderHeader;
  final double? height;
  final int? maxLength;
  final bool hideCounter;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final Widget? suffix;
  final List<TextInputFormatter>? formatter;
  final Widget? prefix;
  final Color? filledColor;
  final Color? cursorColor;
  final Color? borderColor;
  final double borderRadius;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedErrorBorder;
  final Widget? customHeader;
  final void Function(String?)? onChange;
  final void Function()? onTap;
  final void Function(String?)? onSubmit;
  final void Function()? onEditingComplete;
  final ScrollController? scrollController;

  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.validator,
    this.style,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.showCursor,
    this.enabled = true,
    this.padding,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.obscuringCharacter = '*',
    this.obscureText = false,
    this.unfocusOnTapOutside = true,
    this.autocorrect = true,
    this.headerText,
    this.filled,
    this.smartDashesType,
    this.smartQuotesType,
    this.keyboardType,
    this.textInputAction,
    this.textDirection,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.canRequestFocus = true,
    this.headerStyle,
    this.gapUnderHeader = 0,
    this.height,
    this.maxLength,
    this.hideCounter = false,
    this.helperText,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.suffix,
    this.formatter,
    this.prefix,
    this.filledColor,
    this.cursorColor,
    this.borderColor,
    this.borderRadius = 12,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.disabledBorder,
    this.focusedErrorBorder,
    this.customHeader,
    this.onChange,
    this.onTap,
    this.onSubmit,
    this.onEditingComplete,
    this.scrollController,
  }) : assert(
         controller == null || initialValue == null,
         'Cannot provide both controller and initialValue.',
       ),
       assert(
         !expands || height != null,
         'height is required when expands is true.',
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
        children: [?_header(context), _textField(context)],
      );
    }
    return _textField(context);
  }

  Widget _textField(BuildContext context) {
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
      child: TextFormField(
        obscureText: obscureText,
        textDirection: textDirection,
        enabled: enabled,
        canRequestFocus: canRequestFocus,
        onChanged: onChange,
        onTap: onTap,
        onTapOutside: unfocusOnTapOutside
            ? (_) => FocusScope.of(context).unfocus()
            : null,
        obscuringCharacter: obscuringCharacter,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        inputFormatters: formatter,
        controller: controller,
        focusNode: focusNode,
        cursorColor: cursorColor ?? decoration.focusedBorder?.borderSide.color,
        textAlign: textAlign,
        onFieldSubmitted: onSubmit,
        onEditingComplete: onEditingComplete,
        initialValue: initialValue,
        validator: validator,
        autofocus: autofocus,
        readOnly: readOnly,
        showCursor: showCursor,
        autocorrect: autocorrect,
        smartDashesType: smartDashesType,
        smartQuotesType: smartQuotesType,
        maxLines: maxLines,
        minLines: minLines,
        expands: expands,
        maxLength: maxLength,
        scrollController: scrollController,
        style: style ?? context.textTheme.bodySmall,
        autovalidateMode: autoValidateMode,
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
          counterText: hideCounter ? '' : null,
          counterStyle: resolvedHintStyle,
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
