import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/features/location/domain/entity/location_entity.dart';

class Location {
  final String? name;
  final LatLong coordinates;

  const Location({required this.name, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String?,
      coordinates: LatLong.fromJson(json),
    );
  }

  LocationEntity toEntity() =>
      LocationEntity(name: name, lat: coordinates.lat, long: coordinates.long);
}
