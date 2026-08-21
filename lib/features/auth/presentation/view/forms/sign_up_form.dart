import 'package:shefaa/shared/presentation/view/forms/base_auth_form.dart';
import 'package:shefaa/features/auth/presentation/view/widgets/privacy_policy_agreement.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/email_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/password_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/username_field.dart';

class SignUpForm extends BaseAuthForm {
  SignUpForm({super.key, super.formKey})
    : super(
        fields: [const UsernameField(), const EmailField(), PasswordField()],
        footer: const PrivacyPolicyAgreement(),
      );
}
