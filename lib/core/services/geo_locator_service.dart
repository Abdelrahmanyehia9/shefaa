import 'package:geolocator/geolocator.dart';

final class GeolocatorService {
  const GeolocatorService();
  /// Check if the location service is enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
  /// Get the current location
  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }
      final Position position = Position(
        longitude: 38.9968,
        latitude: 34.8021,
        timestamp: DateTime.now(),
        accuracy: 10,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      );
      return position;
    } catch (e) {
      return null;
    }
  }
  /// Get the current location stream
  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }
  /// Get the distance between two points
  Future<double> getDistanceBetween(
      double startLat,
      double startLng,
      double endLat,
      double endLng,
      ) async {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }
  /// Open app settings
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}