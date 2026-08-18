import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/auth/presentation/view/forms/sign_in_form.dart';
import 'package:shefaa/features/auth/presentation/view/layouts/auth_layout.dart';
import 'package:shefaa/features/auth/presentation/view/widgets/auth_switcher.dart';
import 'package:shefaa/features/auth/presentation/view/widgets/social_login.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      bottomPadding: false,
      body: AuthLayout(
        title: "تسجيل الدخول",
        description: "سجّل دخولك للمتابعة والاستمتاع بتجربة  أسهل وأسرع.",
        action: AppButton.filled(
          "تسجيل الدخول",
          onTap: () => context.pushNamed(Routes.otp),
        ),
        form: SignInForm(),
        footer: const Column(children: [SocialLogin(), AuthSwitcher()]),
      ),
    );
  }
}
