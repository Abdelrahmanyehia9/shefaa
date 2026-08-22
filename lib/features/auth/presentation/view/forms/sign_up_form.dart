import 'package:flutter/material.dart';
import 'package:shefaa/shared/presentation/view/forms/base_auth_form.dart';
import 'package:shefaa/features/auth/presentation/view/widgets/privacy_policy_agreement.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/email_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/password_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/username_field.dart';

class SignUpForm extends BaseAuthForm {
  SignUpForm({
    super.key,
    super.formKey,
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController email,
    required TextEditingController password,
  }) : super(
         fields: [
           UsernameField(firstController: firstName, lastController: lastName),
           EmailField(controller: email),
           PasswordField(controller: password),
         ],
         footer: const PrivacyPolicyAgreement(),
       );
}
