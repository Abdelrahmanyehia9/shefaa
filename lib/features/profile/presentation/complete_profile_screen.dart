import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/extensions/snack_bar.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/profile/presentation/controller/complete_profile_cubit.dart';
import 'package:shefaa/features/profile/presentation/forms/complete_profile_form.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';
import 'package:shefaa/shared/presentation/view/layout/auth_layout.dart';

class CompleteProfileScreen extends StatefulWidget {
  final UserEntity user;

  const CompleteProfileScreen({super.key, required this.user});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  late final TextEditingController _firstnameController;

  late final TextEditingController _lastnameController;

  late final TextEditingController _phoneController;

  late final GlobalKey<FormState> _formKey;

  Country _country = Country.parse("EG");
  DateTime? _dob;
  late Gender _gender;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _firstnameController = TextEditingController(text: widget.user.firstname);
    _lastnameController = TextEditingController(text: widget.user.lastName);
    _phoneController = TextEditingController(
      text: widget.user.phoneNumber?.phone,
    );
    _dob = widget.user.dob;
    _gender = widget.user.gender;
    _country = widget.user.phoneNumber?.country ?? Country.parse("EG");
    super.initState();
  }

  Future<void> _onCompleteProfile() async {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<CompleteProfileCubit>();
    cubit.update(
      uid: widget.user.uid,
      gender: _gender,
      phone: PhoneNumber(
        country: _country,
        phone: _phoneController.text.trim(),
      ),
      dop: _dob,
      firstname: _firstnameController.text,
      lastname: _lastnameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<CompleteProfileCubit, Unit>(
      onLoading: context.loaderOverlay.show,
      onLoaded: (s) {
        if (s.isFailure) context.errorBar(s.error!);
        context.loaderOverlay.hide();
      },
      builder: (_) => AppScaffold(
        appBar: AppBar(),
        hPadding: 0,
        bottomPadding: false,
        body: AuthLayout(
          title: "أكمل ملفك الشخصي",
          description:
              "لا تقلق، بياناتك الشخصية خاصة بك ولن يتمكن أي شخص آخر من رؤيتها.",
          form: CompleteProfileForm(
            formKey: _formKey,
            lastName: _lastnameController,
            onDobChange: (date) => _dob = date,
            firstName: _firstnameController,
            phone: _phoneController,
            dop: _dob,
            onCountryChange: (country) => _country = country,
            onGenderChange: (gender) => _gender = gender,
            initialGender: _gender,
            initialCountry: _country,
          ),
          action: AppButton.filled("تاكيد", onTap: _onCompleteProfile),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
