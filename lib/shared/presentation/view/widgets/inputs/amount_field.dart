import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/app_validation.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.controller,
    this.min,
    this.max,
    this.required = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final int? min;
  final int? max;
  final bool required;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      onChange: onChanged,
      formatter: [
        _AmountInputFormatter(min: min, max: max),
        FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: context.colors.primary),
      ),
      controller: controller,
      labelText: "اكتب المبلغ",
      validator: (value) => AppValidation.validateAmount(
        value,
        required: required,
        min: min,
        max: max,
      ),
    );
  }
}
class _AmountInputFormatter extends TextInputFormatter {
  const _AmountInputFormatter({this.min, this.max});

  final int? min;
  final int? max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) return newValue;

    final value = int.tryParse(newValue.text);
    if (value == null) return oldValue;

    if (max != null && value > max!) return oldValue;

    return newValue;
  }
}