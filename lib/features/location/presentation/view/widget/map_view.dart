import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/location/presentation/view/widget/map_controls.dart';

class MapView extends StatefulWidget {
  final Position? initialPoint;
  final double initialZoom;

  const MapView({
    super.key,
    this.initialPoint,
    this.initialZoom = 12,
  });

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  MapboxMap? _mapboxMap;
  late final CameraViewportState _viewport;

  @override
  void initState() {
    super.initState();
    _viewport = CameraViewportState(
      center:widget.initialPoint == null ? null :  Point(coordinates: widget.initialPoint!),
      zoom: widget.initialZoom,
    );
  }

  void _onMapCreated(MapboxMap map) {
    _mapboxMap = map;
    map.compass.updateSettings(CompassSettings(enabled: false));
    map.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
  }

  Future<void> _zoomBy(double delta) async {
    final map = _mapboxMap;
    if (map == null) return;
    final camera = await map.getCameraState();
    await map.easeTo(
      CameraOptions(zoom: camera.zoom + delta),
      MapAnimationOptions(duration: 300),
    );
  }

  Future<void> _goToMyLocation() async {
    final map = _mapboxMap;
    if (map == null || widget.initialPoint == null) return;
    flyTo(
      lat: widget.initialPoint!.lat.toDouble(),
      lon: widget.initialPoint!.lng.toDouble(),
    );
  }

  Future<void> flyTo({required double lat, required double lon}) async {
    final map = _mapboxMap;
    await map?.flyTo(
      CameraOptions(
        center: Point(coordinates: Position(lon, lat)),
        zoom: widget.initialZoom,
      ),
      MapAnimationOptions(duration: 800),
    );
  }

  Future<({double lat, double lng})?> getSelectedLocation() async {
    final camera = await _mapboxMap?.getCameraState();
    if (camera == null) return null;
    return (
      lat: camera.center.coordinates.lat.toDouble(),
      lng: camera.center.coordinates.lng.toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MapWidget(viewport: _viewport, onMapCreated: _onMapCreated),
        Positioned.directional(
          textDirection: Directionality.of(context),
          bottom: UISizes.sp16,
          end: UISizes.sp16,
          child: MapControls(
            size: UISizes.sp24,
            onZoomIn: () => _zoomBy(1),
            onZoomOut: () => _zoomBy(-1),
            onMyLocation: _goToMyLocation,
          ),
        ),
        Center(
          child: Icon(
            AppIcons.locationFilled,
            size: UISizes.sp48,
            color: context.colors.primary,
          ),
        ),
      ],
    );
  }
}
