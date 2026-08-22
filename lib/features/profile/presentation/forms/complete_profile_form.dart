import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/shared/presentation/view/forms/base_auth_form.dart';
import 'package:shefaa/shared/presentation/view/widgets/user_edit_avatar.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/date_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/phone_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/username_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/gender_selector.dart';

class CompleteProfileForm extends BaseAuthForm {
  CompleteProfileForm({
    super.key,
    super.formKey,
    required TextEditingController firstName,
    DateTime? dop,
    required TextEditingController lastName,
    required TextEditingController phone,
    required ValueChanged<Country> onCountryChange,
    required ValueChanged<DateTime> onDobChange,
    required Country initialCountry,
    required Gender initialGender,
    required ValueChanged<Gender> onGenderChange,
  }) : super(
         fields: [
           const UserEditAvatar(),
           UsernameField(firstController: firstName, lastController: lastName),
           PhoneField(
             controller: phone,
             initialCountry: initialCountry,
             onCountryChange: onCountryChange,
           ),
           DateField(initialDate: dop, onChanged: onDobChange),
           GenderSelector(gender: initialGender, onChanged: onGenderChange),
         ],
       );
}
