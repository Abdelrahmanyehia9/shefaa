import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/features/location/data/models/location.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';

class UserLocation extends Location {
  final bool? isSelected;
  final String government;
  final String area;
  final String build;
  final String flatNo;
  final String street ;
  final String floor;

  const UserLocation({
    super.id,
    required super.name,
    required super.coordinates,
    required this.government,
    required this.area,
    required this.build,
    required this.flatNo,
    required this.street,
    required this.floor,
    this.isSelected,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
    id: json['id'] as int?,
    name: json['name'] as String?,
    coordinates: LatLong.fromJson(json),
    isSelected: json['is_selected'] as bool,
    government: json['government'] as String,
    area: json['area'] as String,
    build: json['build'] as String,
    street: json['street'] as String,
    flatNo: json['flat_no'] as String,
    floor: json['floor'] as String,
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    'name': name,
    'lat': coordinates.lat,
    'long': coordinates.long,
    'street':street,
    'is_selected': isSelected,
    'government': government,
    'area': area,
    'build': build,
    'flat_no': flatNo,
    'floor': floor,
  }.withoutNulls();

  @override
  UserLocationEntity toEntity() => UserLocationEntity(
    name: name,
    id: id??0,
    lat: coordinates.lat,
    long: coordinates.long,
    isSelected: isSelected??false,
    street: street,
    government: government,
    area: area,
    build: build,
    flatNo: flatNo,
    floor: floor,
  );
}