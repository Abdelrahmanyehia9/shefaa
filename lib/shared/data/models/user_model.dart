import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/enum/user_role.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';

class UserModel {
  final String id;
  final String? profilePic;
  final String? firstname;
  final String? email;
  final String? lastName;
  final DateTime? dob;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Gender? gender;
  final PhoneNumber? phone;
  final UserRole? role;

  const UserModel({
    required this.id,
    this.profilePic,
    this.firstname,
    this.email,
    this.lastName,
    this.dob,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.gender,
     this.role
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    profilePic: json['profile_pic'] as String?,
    firstname: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    email:  json['email'] as String?,
    dob: json['dob'] != null ? DateTime.parse(json['dob'] as String) : null,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    gender: json['gender'] != null
        ? Gender.values.byName(json['gender'] as String)
        : null,
    phone: json['phone'] == null ? null : PhoneNumber.fromJson(json['phone']),
    role: json['role'] == null ? null :enumFromJson(json["role"], UserRole.values)?? UserRole.patient
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_pic': profilePic,
      'first_name': firstname,
      'last_name': lastName,
      'dob': dob?.toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'gender': gender?.name,
      "phone": phone?.toJson(),
      "role": role?.name,
      "email" : email
    };
  }

  UserEntity toEntity() => UserEntity(
    uid: id,
    firstname: firstname,
    lastName: lastName,
    dob: dob,
    gender: gender ?? Gender.male,
    profilePic: profilePic,
    phoneNumber: phone,
    role: role??UserRole.patient,
    email: email

  );

}
