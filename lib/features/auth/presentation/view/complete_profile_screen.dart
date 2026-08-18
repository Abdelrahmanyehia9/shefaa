import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/features/auth/presentation/view/forms/complete_profile_form.dart';
import 'package:shefaa/features/auth/presentation/view/layouts/auth_layout.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      bottomPadding: false,
      body: AuthLayout(
        title: "أكمل ملفك الشخصي",
        description:
            "لا تقلق، بياناتك الشخصية خاصة بك ولن يتمكن أي شخص آخر من رؤيتها.",
        form: CompleteProfileForm(
          onCountryChange: (country) {},
          onGenderChange: (gender) {},
          initialGender: Gender.male,
          initialCountry: Country.parse("EG"),
        ),
        action: AppButton.filled("تاكيد"),
      ),
    );
  }
}
