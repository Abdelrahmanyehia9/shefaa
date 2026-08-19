import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/features/auth/presentation/view/forms/sign_up_form.dart';
import 'package:shefaa/features/auth/presentation/view/layouts/auth_layout.dart';
import 'package:shefaa/features/auth/presentation/view/widgets/toggle_sign_in_and_signup.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,

      bottomPadding: false,
      body: AuthLayout(
        title: "انشاء حساب",
        description: "أنشئ حسابك وابدأ في إدارة خدماتك الطبية بسهولة.",
        form: SignUpForm(),
        action: AppButton.filled("تسجيل"),
        footer: const ToggleSignInAndSignup(isSignup: true).paddingVr,
      ),
    );
  }
}
