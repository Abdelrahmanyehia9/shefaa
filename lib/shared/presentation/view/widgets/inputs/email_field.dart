import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/helper/app_validation.dart';

class EmailField extends StatelessWidget {
  final TextEditingController? controller;
  const EmailField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
        validator:(e)=> AppValidation.validateEmail(e, true),
        controller: controller, labelText: "البريد الالكتروني");
  }
}
