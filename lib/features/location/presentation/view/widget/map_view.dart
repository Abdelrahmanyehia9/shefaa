import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_assets.dart';
import 'package:shefaa/features/location/presentation/view/widget/map_controls.dart';

class MapMarker {
  final String id;
  final double latitude;
  final double longitude;
  final String? label;
  final Object? data;

  MapMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.label,
    this.data,
  });
}

class MapView extends StatefulWidget {
  final Point? initialPoint;
  final double initialZoom;
  final List<MapMarker> markers;
  final bool showUserLocation;
  final bool showControllers;
  final bool showZoomControls;
  final bool showMyLocationControl;
  final double controllersBottom;
  final void Function(MapboxMap mapboxMap)? onMapCreated;
  final void Function(MapboxMap mapboxMap)? onStyleLoaded;
  final void Function(Point coordinate)? onMapTap;
  final void Function(MapMarker marker)? onMarkerTap;
  final void Function(CameraState cameraState)? onCameraChanged;
  final void Function(CameraState cameraState)? onCameraIdle;
  final void Function(bool moving)? onMovingChanged;
  final void Function()? goingToUserLocation;
  final void Function(Position userPosition)? onUserLocationUpdated;

  const MapView({
    super.key,
    this.initialPoint,
    this.initialZoom = 14,
    this.markers = const [],
    this.showUserLocation = true,
    this.showControllers = true,
    this.showZoomControls = true,
    this.showMyLocationControl = true,
    this.controllersBottom = 16,
    this.goingToUserLocation,
    this.onMapCreated,
    this.onStyleLoaded,
    this.onMapTap,
    this.onMarkerTap,
    this.onCameraChanged,
    this.onCameraIdle,
    this.onMovingChanged,
    this.onUserLocationUpdated,
  });

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  static const _idleDelay = Duration(milliseconds: 400);
  static const _markerAsset = AppAssets.logoPng;
  static const _markerSize = 0.3; // غيّر الرقم ده لو عايز أكبر أو أصغر

  MapboxMap? mapboxMap;
  PointAnnotationManager? _annotationManager;
  final Map<String, MapMarker> _annotationMarkerMap = {};
  List<MapMarker> _currentMarkers = [];
  Uint8List? _markerImage;
  int _renderVersion = 0;
  bool _moving = false;

  late final CameraViewportState _viewport;
  late final String _debounceTag = 'map-moving-$hashCode';

  @override
  void initState() {
    super.initState();
    _currentMarkers = widget.markers;
    _viewport = CameraViewportState(
      pitch: 30,
      center: widget.initialPoint,
      zoom: widget.initialZoom,
    );
  }

  @override
  void didUpdateWidget(covariant MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameMarkers(widget.markers, oldWidget.markers)) {
      _currentMarkers = widget.markers;
      _renderMarkers();
    }
  }

  @override
  void dispose() {
    EasyDebounce.cancel(_debounceTag);
    super.dispose();
  }

  bool _sameMarkers(List<MapMarker> a, List<MapMarker> b) =>
      identical(a, b) ||
          (a.length == b.length &&
              Iterable<int>.generate(a.length).every((i) =>
              a[i].id == b[i].id &&
                  a[i].latitude == b[i].latitude &&
                  a[i].longitude == b[i].longitude &&
                  a[i].label == b[i].label));

  void _setMoving(bool value) {
    if (_moving == value) return;
    _moving = value;
    widget.onMovingChanged?.call(value);
  }

  Future<void> _emitCameraState(void Function(CameraState)? callback) async {
    if (callback == null) return;
    final state = await mapboxMap?.getCameraState();
    if (state != null) callback(state);
  }

  void _onCameraChangeListener(CameraChangedEventData data) {
    _setMoving(true);
    EasyDebounce.debounce(_debounceTag, _idleDelay, () => _setMoving(false));
    _emitCameraState(widget.onCameraChanged);
  }

  void _onMapIdleListener(MapIdleEventData data) {
    EasyDebounce.cancel(_debounceTag);
    _setMoving(false);
    _emitCameraState(widget.onCameraIdle);
  }

  Future<void> _onMapCreated(MapboxMap map) async {
    mapboxMap = map;
    map.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    map.compass.updateSettings(CompassSettings(enabled: false));
    if (widget.showUserLocation) {
      await map.location.updateSettings(
        LocationComponentSettings(enabled: true, pulsingEnabled: true),
      );
    }

    _annotationManager = await map.annotations.createPointAnnotationManager();
    _annotationManager?.tapEvents(
      onTap: (annotation) {
        final marker = _annotationMarkerMap[annotation.id];
        if (marker != null) widget.onMarkerTap?.call(marker);
      },
    );

    await _renderMarkers();
    widget.onMapCreated?.call(map);
  }

  void _onStyleLoaded(StyleLoadedEventData data) {
    if (mapboxMap != null) widget.onStyleLoaded?.call(mapboxMap!);
  }

  Future<void> _renderMarkers() async {
    final manager = _annotationManager;
    if (manager == null) return;

    final version = ++_renderVersion;
    _markerImage ??= (await rootBundle.load(_markerAsset)).buffer.asUint8List();
    if (version != _renderVersion) return;

    await manager.deleteAll();
    if (version != _renderVersion) return;
    _annotationMarkerMap.clear();

    final markers = List<MapMarker>.of(_currentMarkers);
    if (markers.isEmpty) return;

    final created = await manager.createMulti([
      for (final m in markers)
        PointAnnotationOptions(
          geometry: Point(coordinates: Position(m.longitude, m.latitude)),
          image: _markerImage,
          iconSize: _markerSize,
          iconAnchor: IconAnchor.BOTTOM,
          textField: m.label,
          textOffset: [0, 1],
          textSize: 12,
        ),
    ]);

    if (version != _renderVersion) return;
    for (var i = 0; i < created.length; i++) {
      final annotation = created[i];
      if (annotation != null) _annotationMarkerMap[annotation.id] = markers[i];
    }
  }

  Future<void> setMarkers(List<MapMarker> markers) async {
    _currentMarkers = markers;
    await _renderMarkers();
  }

  Future<void> flyTo(double lat, double lng, {double zoom = 15}) async {
    await mapboxMap?.flyTo(
      CameraOptions(
        center: Point(coordinates: Position(lng, lat)),
        zoom: zoom,
      ),
      MapAnimationOptions(duration: 1000),
    );
  }

  Future<void> zoomBy(double delta) async {
    final map = mapboxMap;
    if (map == null) return;
    final camera = await map.getCameraState();
    await map.easeTo(
      CameraOptions(zoom: camera.zoom + delta),
      MapAnimationOptions(duration: 300),
    );
  }

  Future<CameraState?> getCameraState() async => mapboxMap?.getCameraState();

  void notifyUserLocation(Position position) =>
      widget.onUserLocationUpdated?.call(position);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MapWidget(
          viewport: _viewport,
          onMapCreated: _onMapCreated,
          onStyleLoadedListener: _onStyleLoaded,
          onCameraChangeListener: _onCameraChangeListener,
          onMapIdleListener: _onMapIdleListener,
        ),
        Positioned.directional(
          textDirection: Directionality.of(context),
          end: UISizes.w8,
          bottom: UISizes.h24,
          child: MapControls(
            enabled: widget.showControllers,
            showZoom: widget.showZoomControls,
            showMyLocation: widget.showMyLocationControl,
            onZoomIn: () => zoomBy(1),
            onZoomOut: () => zoomBy(-1),
            onMyLocation: widget.goingToUserLocation,
          ),
        ),
      ],
    );
  }
}