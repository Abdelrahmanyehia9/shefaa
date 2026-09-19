import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/extensions/snack_bar.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/profile/presentation/controller/update_profile_cubit.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';
import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/date_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/email_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/phone_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/username_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/gender_selector.dart';
import 'package:shefaa/shared/presentation/view/widgets/user_edit_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late DateTime? _date;
  late Gender _gender;
  late Country _country;

  @override
  void initState() {
    final currentUser = sessionCubit.currentUser;
    _firstName = TextEditingController(text: currentUser?.firstname ?? "");
    _lastName = TextEditingController(text: currentUser?.lastName ?? "");
    _email = TextEditingController(text: currentUser?.email ?? "");
    _phone = TextEditingController(text: currentUser?.phoneNumber?.phone ?? "");
    _country = currentUser?.phoneNumber?.country ?? Country.parse("EG");
    _date = currentUser?.dob;
    _gender = currentUser?.gender ?? Gender.male;
    super.initState();
  }

  Future<void> onEdit() async{
    final currentUser = sessionCubit.currentUser;
    final UserModel user  = UserModel( id: currentUser!.uid,
      role: currentUser.role,
      gender: _gender,
      firstname: _firstName.text,
      lastName:  _lastName.text,
      email: _email.text.trim(),
      phone:  PhoneNumber(country: _country, phone: _phone.text.trim()),
      dob: _date,);
    if(currentUser == user.toEntity()){
      return context.warningBar(message: "لا يوجد تغيير");
    }
   await context.read<UpdateProfileCubit>().update(
     user: user
     );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();
    return AppScaffold(
      appBar: AppBar(title: const AppText("تعديل الملف الشخصي")),
      body: BaseBlocConsumer(
        bloc: cubit,
        onLoading: context.loaderOverlay.show,
        onLoaded: (s) {
          if (s.isSuccess) {
            context.successBar(message: "تم تعديل المستخدم بنجاح");
          }
          if (s.isFailure) {
            context.errorBar(s.error!);
          }
          context.loaderOverlay.hide();
        },
        builder: (s) => SingleChildScrollView(
          child: Column(
            spacing: UISizes.h16,
            children: [
              const UserEditAvatar().paddingVr,
              UsernameField(
                firstController: _firstName,
                lastController: _lastName,
              ),
              PhoneField(
                controller: _phone,
                initialCountry: _country,
                onCountryChange: (c) => _country = c,
              ),
              EmailField(controller: _email),
              DateField(initialDate: _date, onChanged: (d) => _date = d),
              GenderSelector(gender: _gender, onChanged: (g) => _gender = g),
              AppButton.filled("تاكيد", onTap: onEdit),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }
}
