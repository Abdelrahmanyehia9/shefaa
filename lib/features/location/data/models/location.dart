import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/features/location/domain/entity/location_entity.dart';

class Location {
  final String? name;
  final LatLong coordinates;
  final int? id ;

  const Location({ this.id,required this.name, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'] as String?,
      coordinates: LatLong.fromJson(json),
    );
  }

  Map<String, dynamic>toJson()=>{
    "name" : name ,
    'lat': coordinates.lat,
    "long": coordinates.long,
  };

  LocationEntity toEntity() =>
      LocationEntity(name: name, lat: coordinates.lat, long: coordinates.long);
}
