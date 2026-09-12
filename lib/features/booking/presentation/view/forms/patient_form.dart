import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/booking/presentation/controller/patient_form_controller.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/date_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/phone_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/username_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/gender_selector.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/kinship_selector.dart';

class PatientForm extends StatefulWidget {
  final PatientFormController controller;

  const PatientForm({
    super.key,
    required this.controller,
  });

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    return Form(
      key: widget.controller.formKey,
      child: AppStaggeredAnimation(
        spacing: UISizes.h16,
        children: [
          UsernameField(
            firstController: c.firstname,
            lastController: c.lastname,

          ),
          DateField(
            initialDate: c.dob,
            onChanged: (d) => c.dob = d,
          ),
          GenderSelector(
            gender: c.gender,
            onChanged: (g) => setState(() => c.gender = g),
          ),
          KinshipSelector(
            kinship: c.kinship,
            onChanged: (k) => c.kinship = k,
          ),
          PhoneField(
            initialCountry: c.country,
            onCountryChange: (country) => c.country = country,
            controller: c.phone,
          ),
        ],
      ),
    );
  }
}