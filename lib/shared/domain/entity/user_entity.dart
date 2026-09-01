import 'package:equatable/equatable.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/utils/fake_data.dart';
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

  static UserEntity get mock => UserEntity(uid: FakeData.string());
  String get completeName => '${firstname ?? ""}  ${lastName ?? ""}';
}

extension UserEntExt on UserEntity {
  bool get isCompleteUser {
    final values = [firstname, lastName, dob, phoneNumber];
    return values.every((e) => e != null);
  }

  bool get isYou {
    if (sessionCubit.currentUser == null) {
      return false;
    } else {
      return uid == sessionCubit.currentUser!.uid;
    }
  }
}
