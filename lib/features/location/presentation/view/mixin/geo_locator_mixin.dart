import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/core/services/geo_locator_service.dart';

mixin GeoLocatorMixin<T extends StatefulWidget> on State<T> {
  final _service = GeolocatorService.instance;
  mp.Position? position;
  bool _fetching = false;

  void onPositionUpdated(mp.Position position);

  Future<void> moveToUser(LatLong? initial) async {
    if (_fetching) return;
    if (initial != null) {
      setState(() => position = mp.Position(initial.long, initial.lat));
      return;
    }
    _fetching = true;
    try {
      final loc = await _service.getCurrentLocation();
      if (!mounted || loc == null) return;
      final hadMap = position != null;
      setState(() => position = mp.Position(loc.longitude, loc.latitude));
      if (hadMap) onPositionUpdated(position!);
    } finally {
      _fetching = false;
    }
  }
}