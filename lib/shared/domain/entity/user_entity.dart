import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? profilePic;
  final String? firstname, lastName;
  final DateTime? dob;
  final Gender gender;
  final String? email;
  final PhoneNumber? phoneNumber;

  const UserEntity({
    required this.uid,
    this.profilePic,
    this.firstname,
    this.lastName,
    this.dob,
    this.gender = Gender.male,
    this.email,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [uid];
}

extension UserEntExt on UserEntity {
  UserModel toUserModel() => UserModel(
    id: uid,
    firstname: firstname,
    profilePic: profilePic,
    lastName: lastName,
    gender: gender,
    dob: dob,
    phone: phoneNumber,
  );

  bool get isCompleteUser {
    final values = [firstname, lastName, dob, phoneNumber];
    return values.every((e) => e != null);
  }
}
