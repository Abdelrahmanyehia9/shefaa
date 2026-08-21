import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';

class UserEntity extends Equatable{
  final String uid;
  final String? profilePic;
  final String firstname, lastName;
  final DateTime dob;
  final Gender gender;
  final String? email;
  final PhoneNumber? phoneNumber;

  const UserEntity({
    required this.uid,
    this.profilePic,
    required this.firstname,
    required this.lastName,
    required this.dob,
    this.gender= Gender.male,
    this.email,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [uid];
}
