import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';

class UserModel {
  final String id;
  final String? profilePic;
  final String? firstname;
  final String? lastName;
  final DateTime? dob;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Gender? gender;
  final PhoneNumber? phone;

  const UserModel({
    required this.id,
    this.profilePic,
    this.firstname,
    this.lastName,
    this.dob,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    profilePic: json['profile_pic'] as String?,
    firstname: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    dob: json['dob'] != null ? DateTime.parse(json['dob'] as String) : null,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    gender: json['gender'] != null
        ? Gender.values.byName(json['gender'] as String)
        : null,
    phone: json['phone'] == null ? null : PhoneNumber.fromJson(json['phone']),
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
    };
  }

  UserEntity toEntity() => UserEntity(
    uid: id,
    firstname: firstname,
    lastName: lastName,
    dob: dob,
    phoneNumber: phone,
  );
}
