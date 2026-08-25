import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/date_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/email_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/phone_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/username_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/gender_selector.dart';
import 'package:shefaa/shared/presentation/view/widgets/user_edit_avatar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const AppText("تعديل الملف الشخصي")),
      body: SingleChildScrollView(
        child: Column(
          spacing: UISizes.h16,
          children: [
            const UserEditAvatar().paddingVr,
            const UsernameField(),
            PhoneField(
              initialCountry: Country.parse("EG"),
              onCountryChange: (_) {},
            ),
            const EmailField(),
            const DateField(),
            GenderSelector(gender: Gender.male, onChanged: (_) {}),
            AppButton.filled("تاكيد"),
          ],
        ),
      ),
    );
  }
}
