import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/app_validation.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isConfirmed;
  final String? Function(String?)? validator;

  const PasswordField._({
    this.isConfirmed = false,
    this.validator,
    this.controller,
  });

  factory PasswordField({TextEditingController? controller}) => PasswordField._(
    controller: controller,
    validator: AppValidation.validatePassword,
  );

  factory PasswordField.confirm({
    TextEditingController? controller,
    TextEditingController? passwordController,
  }) => PasswordField._(
    controller: controller,
    isConfirmed: true,
    validator: (value) => AppValidation.validatePasswordConfirmation(
      passwordController?.text,
      value,
    ),
  );

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final ValueNotifier<bool> isHidden = ValueNotifier(true);

  @override
  void dispose() {
    isHidden.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String label = widget.isConfirmed
        ? "تاكيد كلمة المرور"
        : "كلمة المرور";

    return ValueListenableBuilder<bool>(
      valueListenable: isHidden,
      builder: (context, value, child) {
        return AppTextField(
          obscureText: value,
          validator: widget.validator,
          suffix: AppClick(
            onTap: () => isHidden.value = !isHidden.value,
            child: Icon(
              value ? AppIcons.eyeSlash : AppIcons.eye,
              size: UISizes.sp28,
            ).paddingHr,
          ),
          controller: widget.controller,
          labelText: label,
        );
      },
    );
  }
}
