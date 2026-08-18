import 'package:shefaa/features/auth/presentation/view/forms/base_auth_form.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/email_field.dart';

class ResetPasswordForm extends BaseAuthForm {
  ResetPasswordForm({super.key, super.formKey})
    : super(fields: [const EmailField()]);
}
