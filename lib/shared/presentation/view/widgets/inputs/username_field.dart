import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController? firstController, lastController;

  const UsernameField({super.key, this.firstController, this.lastController});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w8,
      children: [
        Expanded(
          child: AppTextField(
            controller: firstController,
            labelText: "الاسم الاول",
            maxLength: 50,
            hideCounter: true,
          ),
        ),
        Expanded(
          child: AppTextField(
            controller: lastController,
            labelText: "الاسم الاخير",
            maxLength: 50,
            hideCounter: true,
          ),
        ),
      ],
    );
  }
}
