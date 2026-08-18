import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/features/auth/presentation/view/forms/otp_form.dart';
import 'package:shefaa/features/auth/presentation/view/layouts/auth_layout.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      bottomPadding: false,
      appBar: AppBar(),
      body: AuthLayout(
        title: "تاكيد الرمز",
        description:
            "من فضلك أدخل الكود المكون من 6 أرقام الذي تم إرساله إلى *abdelrahman@gmail.com*",
        form: OtpForm(),
        action: AppButton.filled("تاكيد"),
      ),
    );
  }
}
