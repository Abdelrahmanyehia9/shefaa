import 'package:shefaa/shared/data/models/location.dart';
import 'package:shefaa/shared/data/models/rate.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';

class Clinic {
  final int id;
  final String name;
  final String? image;
  final Location location;
  final Rate rate;

  const Clinic({
    required this.id,
    required this.name,
    this.image,
    required this.location,
    required this.rate,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'] as int,
      name: json['name'] as String,
      rate: Rate.fromJson(json['rate'] as Map<String, dynamic>),
      image: json['logo'] as String?,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );
  }
  Clinic copyWith({
    int? id,
    String? name,
    String? image,
    Location? location,
    Rate? rate,
  }) => Clinic(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    location: location ?? this.location,
    rate: rate ?? this.rate,
  );

  ClinicEntity toEntity() => ClinicEntity(
    id: id.toString(),
    name: name,
    rate: rate.value.toDouble(),
    image: image,
    location: location.toEntity().perspectiveLocation(),
    waitingTimeInMin: 15,
  );
}
