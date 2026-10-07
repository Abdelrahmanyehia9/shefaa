import 'package:flutter/widgets.dart';
import 'package:shefaa/shared/presentation/view/forms/base_auth_form.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/password_field.dart';

class ChangePasswordForm extends BaseAuthForm {
  final TextEditingController passwordController;

  final TextEditingController passwordConfirmController;

  ChangePasswordForm({
    super.key,
    super.formKey,
    required this.passwordController,
    required this.passwordConfirmController,
  }) : super(
         fields: [
           PasswordField(controller: passwordController),
           PasswordField.confirm(
             controller: passwordConfirmController,
             passwordController: passwordController,
           ),
         ],
       );
}
