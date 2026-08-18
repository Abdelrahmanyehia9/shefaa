import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_field.dart';

class EmailField extends StatelessWidget {
  final TextEditingController? controller;
  const EmailField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(controller: controller, labelText: "البريد الالكتروني");
  }
}
