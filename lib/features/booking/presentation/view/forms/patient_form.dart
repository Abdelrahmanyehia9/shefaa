import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/date_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/phone_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/username_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/gender_selector.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/kinship_selector.dart';

class PatientForm extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  const PatientForm({super.key, this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AppStaggeredAnimation(
        spacing: UISizes.h16,
        children: [
          const UsernameField(),
          const DateField(),
          GenderSelector(gender: Gender.male, onChanged: (_) {}),
          const KinshipSelector(),
          PhoneField(initialCountry: Country.parse("EG")),
        ],
      ),
    );
  }
}
