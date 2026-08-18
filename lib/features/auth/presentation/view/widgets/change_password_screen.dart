import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/features/auth/presentation/view/forms/change_password_form.dart';
import 'package:shefaa/features/auth/presentation/view/layouts/auth_layout.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: AuthLayout(
        title: "تعيين كلمة مرور جديدة",
        description:
            "أدخل كلمة مرور جديدة وقوية لتأمين حسابك والحفاظ على بياناتك الشخصية بأمان.",
        form: ChangePasswordForm(),
        action: AppButton.filled("تاكيد"),
      ),
    );
  }
}
