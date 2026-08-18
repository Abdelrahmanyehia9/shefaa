import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_field.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController? controller;
  const UsernameField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      labelText: "اسم المستخدم",
      maxLength: 50,
      hideCounter: true,
    );
  }
}
