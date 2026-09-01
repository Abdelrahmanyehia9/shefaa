import 'package:shefaa/core/enum/docotor_level.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/shared/data/models/location.dart';
import 'package:shefaa/shared/data/models/rate.dart';
import 'package:shefaa/shared/data/models/speciality.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';

class Doctor {
  final int id;
  final String name;
  final String? image;
  final Rate rate;
  final Location? location;
  final Speciality speciality;
  final DoctorLevel level;

  const Doctor({
    required this.id,
    required this.name,
    required this.image,
    required this.rate,
    this.location,
    required this.speciality,
    required this.level,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as int,
      name: json['name'] as String,
      speciality: Speciality.fromJson(json['speciality']),
      image: json['image'] as String?,
      rate: Rate.fromJson(json['rate']),
      level:
          enumFromJson<DoctorLevel>(json['doctor_level'], DoctorLevel.values) ??
          DoctorLevel.specialist,
      location: Location.fromJson(json['clinic']['location']),
    );
  }

  Doctor copyWith({
    int? id,
    String? name,
    Speciality? speciality,
    String? image,
    Rate? rate,
    Location? location,
    DoctorLevel? level,
  }) => Doctor(
    id: id ?? this.id,
    name: name ?? this.name,
    speciality: speciality ?? this.speciality,
    image: image ?? this.image,
    rate: rate ?? this.rate,
    location: location ?? this.location,
    level: level ?? this.level,
  );

  DoctorEntity toEntity() => DoctorEntity(
    id: id,
    name: name,
    speciality: speciality.toEntity(),
    rate: rate.toEntity(),
    level: level,
    image: image,
  );
}
