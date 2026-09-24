import 'package:geolocator/geolocator.dart';

extension LocationPermissionExt on LocationPermission {

  bool get hasPermission => this== LocationPermission.always || this == LocationPermission.whileInUse ;
  bool get noPermission => this == LocationPermission.denied || this == LocationPermission.deniedForever || this == LocationPermission.unableToDetermine ;




}