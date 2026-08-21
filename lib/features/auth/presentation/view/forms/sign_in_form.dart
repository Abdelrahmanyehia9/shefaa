import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/shared/presentation/view/forms/base_auth_form.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/email_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/password_field.dart';

class SignInForm extends BaseAuthForm {
  SignInForm({
    super.key,
    super.formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) : super(
         fields: [
           EmailField(controller: emailController),
           PasswordField(controller: passwordController),
         ],
         footer: const _ForgetPasswordButton(),
       );
}

class _ForgetPasswordButton extends StatelessWidget {
  const _ForgetPasswordButton();

  @override
  Widget build(BuildContext context) {
    return AppButton.text(
      onTap: () => context.pushNamed(Routes.resetPassword),
      align: AlignmentGeometry.topEnd,
      "نسيت كلمة المرور ؟",
      style: context.textTheme.titleSmall,
      textColor: context.colors.primary,
    );
  }
}
