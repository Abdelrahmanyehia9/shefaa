import 'package:shefaa/shared/data/models/location.dart';
import 'package:shefaa/shared/data/models/rate.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';

class Clinic {
  final int id;
  final String name;
  final String? imageCover;
  final String? logo;
  final Location location;
  final Rate rate;

  const Clinic({
    required this.id,
    required this.name,
    this.logo,
    this.imageCover,
    required this.location,
    required this.rate,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'] as int,
      name: json['name'] as String,
      rate: Rate.fromJson(json['rate'] as Map<String, dynamic>),
      imageCover: json['cover'] as String?,
      logo: json['logo'] as String?,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );
  }
  Clinic copyWith({
    int? id,
    String? name,
    String? logo,
    Location? location,
    String? imageCover,
    Rate? rate,
  }) =>
      Clinic(
    id: id ?? this.id,
    name: name ?? this.name,
    logo: logo ?? this.logo,
    location: location ?? this.location,
    imageCover: imageCover ?? this.imageCover,
    rate: rate ?? this.rate,
  );

  ClinicEntity toEntity() => ClinicEntity(
    id: id,
    name: name,
    rate: rate.toEntity(),
    coverImage: imageCover,
    logo: logo,
    location: location.toEntity(),
  );
}
