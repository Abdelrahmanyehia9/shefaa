import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/features/auth/presentation/view/forms/base_auth_form.dart';
import 'package:shefaa/features/auth/presentation/view/widgets/otp_count_down.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/otp_field.dart';

class OtpForm extends BaseAuthForm {
  OtpForm({super.key, super.formKey})
    : super(fields: [const OtpField()], footer: const OtpCountDown().paddingVr);
}
