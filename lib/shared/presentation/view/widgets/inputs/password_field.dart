import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isConfirmed;

  const PasswordField._({this.isConfirmed = false, this.controller});
  factory PasswordField({TextEditingController? controller}) =>
      PasswordField._(controller: controller);
  factory PasswordField.confirm({TextEditingController? controller}) =>
      PasswordField._(controller: controller, isConfirmed: true);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  ValueNotifier<bool> isHidden = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final String label = widget.isConfirmed
        ? "تاكيد كلمة المرور"
        : "كلمة المرور";
    return ValueListenableBuilder(
      valueListenable: isHidden,
      builder: (context, value, child) {
        return AppTextField(
          obscureText: value,
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
