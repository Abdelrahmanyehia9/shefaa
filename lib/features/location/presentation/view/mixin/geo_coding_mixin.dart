import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shefaa/core/models/latlang.dart';
mixin GeoCodingMixin<T extends StatefulWidget> on State<T> {
  LatLong get coordinates;

  Placemark? placemark;

  final Geocoding _geocoding = Geocoding();

  Future<void> getLocationFromCoordinates() async {
    final placemarks = await _geocoding.placemarkFromCoordinates(
      coordinates.lat,
      coordinates.long,
    );

    if (!mounted || placemarks.isEmpty) return;

    setState(() {
      placemark = placemarks.first;
    });
  }
}