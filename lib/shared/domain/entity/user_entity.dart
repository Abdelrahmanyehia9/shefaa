import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/enum/user_role.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? profilePic;
  final String? firstname, lastName;
  final DateTime? dob;
  final Gender gender;
  final String? email;
  final PhoneNumber? phoneNumber;
  final UserRole role;
  final List<UserLocationEntity>? addresses;

  const UserEntity({
    required this.uid,
    this.profilePic,
    this.firstname,
    this.lastName,
    this.dob,
    this.gender = Gender.male,
    this.email,
    this.phoneNumber,
    required this.role,
    this.addresses,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    firstname,
    profilePic,
    lastName,
    gender,
    dob,
    phoneNumber,
    role,
  ];

  static UserEntity get mock => UserEntity(
    uid: FakeData.string(),
    role: UserRole.patient,
    dob: FakeData.dateTime,
    firstname: FakeData.string(),
    lastName: FakeData.string(),
  );

  String get completeName => '${firstname ?? ""}  ${lastName ?? ""}';

  UserLocationEntity? get selectedLocation =>
      addresses?.firstWhereOrNull((e) => e.isSelected == true);

  @override
  String toString() {
    return props.map((e) => e.toString()).join("   ,  ");
  }

  UserEntity copyWith({
    String? uid,
    String? profilePic,
    String? firstname,
    String? lastName,
    DateTime? dob,
    Gender? gender,
    String? email,
    PhoneNumber? phoneNumber,
    UserRole? role,
    List<UserLocationEntity>? addresses,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      firstname: firstname ?? this.firstname,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      addresses: addresses ?? this.addresses,
    );
  }
}

extension UserEntExt on UserEntity {
  bool get isCompleteUser {
    final values = [firstname, lastName, dob, phoneNumber];
    return isYou && values.every((e) => e != null);
  }

  bool get isYou {
    if (sessionCubit.currentUser == null) {
      return false;
    } else {
      return uid == sessionCubit.currentUser!.uid;
    }
  }
}
