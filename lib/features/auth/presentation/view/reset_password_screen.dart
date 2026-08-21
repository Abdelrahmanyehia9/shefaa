import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/auth/presentation/view/forms/reset_password_form.dart';
import 'package:shefaa/shared/presentation/view/layout/auth_layout.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      bottomPadding: false,
      appBar: AppBar(),
      body: AuthLayout(
        title: "نسيت كلمة المرور؟",
        description:
            "أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.",
        form: ResetPasswordForm(),
        action: AppButton.filled(
          "ارسال",
          onTap: () => context.pushNamed(Routes.changePassword),
        ),
      ),
    );
  }
}
