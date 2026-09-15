import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/helper/app_validation.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController? firstController, lastController;
  final bool isRequired;
  const UsernameField({
    super.key,
    this.isRequired = false,
    this.firstController,
    this.lastController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w8,
      children: [
        Expanded(
          child: AppTextField(
            controller: firstController,
            labelText: "الاسم الاول",
            validator: isRequired ? AppValidation.validateRequired : null,
            maxLength: 50,
            hideCounter: true,
          ),
        ),
        Expanded(
          child: AppTextField(
            controller: lastController,
            validator: isRequired ? AppValidation.validateRequired : null,
            labelText: "الاسم الاخير",
            maxLength: 50,
            hideCounter: true,
          ),
        ),
      ],
    );
  }
}
