import 'package:equatable/equatable.dart';
import 'package:shefaa/core/services/geo_locator_service.dart';
import 'package:shefaa/core/utils/fake_data.dart';

class LocationEntity extends Equatable {
  final String? name;
  final double lat;
  final double long;

  const LocationEntity({
    required this.name,
    required this.lat,
    required this.long,
  });

  static LocationEntity get mock => LocationEntity(
    name: FakeData.string(),
    lat: FakeData.decimal,
    long: FakeData.decimal,
  );



  @override
  List<Object?> get props => [name, lat, long];
}

extension LocationEntityEXT on LocationEntity {
  double? _distanceFromUserInM(LocationEntity? userLocation) {
    if (userLocation == null) return null;

    return GeolocatorService.instance.getDistanceBetween(
      userLocation.lat,
      userLocation.long,
      lat,
      long,
    );
  }

  String? perspectiveLocation(LocationEntity? userLocation) {
    final distance = _distanceFromUserInM(userLocation);

    if (distance == null) return null;

    if (distance < 1000) {
      return '${distance.round()} م';
    }

    return '${(distance / 1000).toStringAsFixed(1)} كم';
  }

  String? distanceTime(LocationEntity? userLocation) {
    final distance = _distanceFromUserInM(userLocation);

    if (distance == null) return null;

    const averageSpeedKmPerHour = 30;

    final minutes =
    ((distance / 1000) / averageSpeedKmPerHour * 60).ceil();

    if (minutes < 60) {
      return '$minutes دقيقة';
    }

    final hours = minutes / 60;

    if (hours < 24) {
      return '${hours.round()} ساعة';
    }

    final days = hours / 24;

    return '${days.round()} يوم';
  }
}