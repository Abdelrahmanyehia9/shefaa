import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/features/medical/shared/data/models/patient_model.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';
import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/kinship_selector.dart';

class PatientFormController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController phone = TextEditingController();

  DateTime? _dob;
  Kinship? _kinship;
  Country _country = Country.parse("EG");
  Gender _gender = Gender.male;
  bool _isSelfBooking = true;

  DateTime? get dob => _dob;
  bool? get selfBooking => _isSelfBooking;
  Kinship? get kinship => _kinship;
  Country get country => _country;
  Gender get gender => _gender;

  PatientFormController(bool isSelfBooking) {
    firstname.addListener(notifyListeners);
    lastname.addListener(notifyListeners);
    phone.addListener(notifyListeners);
    _isSelfBooking = isSelfBooking;
  }

  set dob(DateTime? value) {
    _dob = value;
    notifyListeners();
  }

  set kinship(Kinship? value) {
    _kinship = value;
    notifyListeners();
  }

  set country(Country value) {
    _country = value;
    notifyListeners();
  }

  set gender(Gender value) {
    _gender = value;
    notifyListeners();
  }

  set selfBooking(bool value) {
    _isSelfBooking = value;
    notifyListeners();
  }

  Patient? customPatient() {
    if (_isSelfBooking) return null;
    return Patient(
      user: UserModel(
        firstname: firstname.text.trim(),
        lastName: lastname.text.trim(),
        dob: _dob,
        phone: PhoneNumber(country: _country, phone: phone.text.trim()),
        gender: _gender,
        id: '0',
      ),
      kinship: _kinship,
    );
  }

  PhoneNumber? get completeUsedPhone => !_isSelfBooking
      ? PhoneNumber(country: country, phone: phone.text.trim())
      : sessionCubit.currentUser?.phoneNumber;

  @override
  void dispose() {
    firstname.removeListener(notifyListeners);
    lastname.removeListener(notifyListeners);
    phone.removeListener(notifyListeners);
    firstname.dispose();
    lastname.dispose();
    phone.dispose();
    super.dispose();
  }
}
