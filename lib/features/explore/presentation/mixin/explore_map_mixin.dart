import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:shefaa/core/services/geo_locator_service.dart';
import 'package:shefaa/features/location/presentation/view/widget/map_view.dart';

mixin ExploreMapMixin<T extends StatefulWidget> on State<T> {
  final mapKey = GlobalKey<MapViewState>();
  final geolocatorService = const GeolocatorService();

  final isMoving = ValueNotifier<bool>(false);
  mp.Position? position;

  static final _fallbackLocation = mp.Position(36.7137, 34.7324);

  void onMovingChanged(bool moving) {
    if (isMoving.value != moving) isMoving.value = moving;
  }

  Future<void> moveToUser() async {
    final loc = await geolocatorService.getCurrentLocation();
    if (!mounted) return;
    setState(() {
      position = loc == null
          ? _fallbackLocation
          : mp.Position(loc.longitude, loc.latitude);
    });
  }

  void flyToPosition(mp.Position? location) {
    final loc = location ?? _fallbackLocation;
    mapKey.currentState?.flyTo(
      loc.lat.toDouble(),
      loc.lng.toDouble(),
      zoom: 13,
    );
  }

  void disposeExploreMap() => isMoving.dispose();
}