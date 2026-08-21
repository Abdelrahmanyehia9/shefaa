import 'package:shefaa/shared/presentation/view/forms/base_auth_form.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/password_field.dart';

class ChangePasswordForm extends BaseAuthForm {
  ChangePasswordForm({super.key, super.formKey})
    : super(fields: [PasswordField(), PasswordField.confirm()]);
}
