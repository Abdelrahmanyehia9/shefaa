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
      formatter: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: context.colors.primary),
      ),
      autofocus: true,
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
