import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/utils/app_configs.dart';

class StaticMapView extends StatelessWidget {
  final double lat;
  final double lon;
  final double zoom;
  final double width;
  final double height;
  final double radius;

  const StaticMapView({
    super.key,
    required this.lat,
    required this.lon,
    this.zoom = 12,
    this.width = 800,
    this.height = 800,
    this.radius = 16,
  });

  static const String _accessToken = AppConfigs.mapToken;

  @override
  Widget build(BuildContext context) {
    final url =
        'https://api.mapbox.com/styles/v1/mapbox/streets-v12/static/'
        'pin-s+ff0000($lon,$lat)/'
        '$lon,$lat,$zoom/${width.toInt()}x${height.toInt()}'
        '?access_token=$_accessToken';

    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAppOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AppCachedNetworkImage(
        url,
        width: width,
        alignment: Alignment.topCenter,
        height: height,
      ),
    );
  }
}