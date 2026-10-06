import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/core/services/geo_locator_service.dart';

mixin GeoLocatorMixin<T extends StatefulWidget> on State<T> {
  final geolocatorService =  GeolocatorService.instance;

  mp.Position? position;


  void onPositionUpdated(mp.Position position);

  Future<void> moveToUser(LatLong? initial) async {
    if(initial !=null){
      setState(() {
        position = mp.Position(initial.long, initial.lat);
      });
    }else{
      final loc  =await geolocatorService.getCurrentLocation();
      if (!mounted || loc == null) return;
      position = mp.Position(loc.longitude, loc.latitude);
      onPositionUpdated(position!);
      setState(() {
      });
    }
  }


}
