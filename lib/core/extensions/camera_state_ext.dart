import 'dart:math';
import 'dart:ui' show Size;

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Size;

extension CameraStateRadius on CameraState {
  double zoomToRadius(
      Size screen, {
        double min = 200,
        double max = 50000,
      }) {
    const metersPerPixelAtZoom0 = 78271.517;

    final lat = center.coordinates.lat.toDouble();

    final metersPerPixel =
        metersPerPixelAtZoom0 *
            cos(lat * pi / 180) /
            pow(2, zoom);

    final halfDiagonalPx =
        sqrt(
          screen.width * screen.width +
              screen.height * screen.height,
        ) /
            2;

    return (metersPerPixel * halfDiagonalPx)

        .toDouble() * .001;
  }

}