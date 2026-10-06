import 'package:geolocator/geolocator.dart';


final class GeolocatorService {
  GeolocatorService._();

  static final GeolocatorService instance = GeolocatorService._();

  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  Future<Position?> getCurrentLocation() async {
    try {
      if (!await isLocationServiceEnabled()) return null;
      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }

  Stream<Position> getPositionStream() => Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ),
  );

  double getDistanceBetween(
      double startLat,
      double startLng,
      double endLat,
      double endLng,
      ) =>
      Geolocator.distanceBetween(startLat, startLng, endLat, endLng);

  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  Future<bool> openAppSettings() => Geolocator.openAppSettings();
}
// Position(
// longitude: 38.9968,
// latitude: 34.8021,
// timestamp: DateTime.now(),
// accuracy: 10,
// altitude: 0,
// altitudeAccuracy: 0,
// heading: 0,
// headingAccuracy: 0,
// speed: 0,
// speedAccuracy: 0,
// );