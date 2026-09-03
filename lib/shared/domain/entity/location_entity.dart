import 'package:shefaa/core/utils/fake_data.dart';

class LocationEntity {
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

  String perspectiveLocation() {
    return "12 كم";
  }
  int distanceTimeInMin()=>16 ;
}
