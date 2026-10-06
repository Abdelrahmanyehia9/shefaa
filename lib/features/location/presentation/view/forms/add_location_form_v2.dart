import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_loader.dart';
import 'package:shefaa/core/enum/app_permission.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/core/utils/app_assets.dart';
import 'package:shefaa/features/location/presentation/view/mixin/geo_locator_mixin.dart';
import 'package:shefaa/features/location/presentation/view/widget/map_view.dart';
import 'package:shefaa/shared/presentation/controllers/permission_cubit.dart';
import 'package:shefaa/shared/presentation/view/widgets/permission_consumer.dart';
import 'package:shefaa/shared/presentation/view/widgets/permission_required_view.dart';

class AddLocationFormV2 extends StatefulWidget {
  final VoidCallback? onSkip ;
  final void Function(LatLong ll)onLocationPicked ;
  final LatLong? initial  ;
  const AddLocationFormV2({super.key, this.initial, this.onSkip, required this.onLocationPicked});

  @override
  State<AddLocationFormV2> createState() => _AddLocationFormV2State();
}

class _AddLocationFormV2State extends State<AddLocationFormV2> with GeoLocatorMixin {
  static const _permission = AppPermission.location;
  final mapKey = GlobalKey<MapViewState>();
  @override
  Widget build(BuildContext context) {
    return PermissionConsumer(
      permission: _permission,
      onGranted:()=> moveToUser(widget.initial),
      deniedBuilder: widget.initial ==null ?  PermissionRequiredView(
          permission: _permission,
          actions: (c) => [
            AppButton.filled(
              "منح الصلاحية",
              onTap: () {
                c.read<PermissionCubit>().request(_permission);
              },
            ),
            if(widget.onSkip !=null)
            AppButton.text(
              "تخطي",
              align: Alignment.center,
              onTap: widget.onSkip,
            ),
          ],
        ).paddingAll : null,
      builder: (s, c) =>  position == null
            ? _buildPlaceHolder()
            : Column(
          children: [
            Expanded(
              child: MapView(
                key: mapKey,
                initialPoint: position,
              ),
            ),
            AppButton.filled(
              "تاكيد",
              fixedSize: Size(context.width, UISizes.sp40 + context.safeBottomArea),
              padding: EdgeInsets.only(
                bottom: context.safeBottomArea
              ),
              radius: 0,

              onTap: onLocationPicked,

            )

          ],
        ),

    );
  }
Widget _buildPlaceHolder(){
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Image.asset(
          color: Colors.white30,
          colorBlendMode: BlendMode.srcATop,
          fit: BoxFit.cover,
          AppAssets.mapPlaceHolder,
        width: double.infinity,
          height: context.height,

        ),
        AppLoader(
          backgroundColor: Colors.transparent,
          size: UISizes.sp164,
        ),
      ],
    );
}

  Future<void> onLocationPicked() async {
    final loc = await mapKey.currentState?.getSelectedLocation();
    final LatLong location = LatLong(
      lat: loc?.lat ?? position!.lat.toDouble(),
      long: loc?.lng ?? position!.lng.toDouble(),
    );

    if (!mounted) return;
    widget.onLocationPicked.call(LatLong(lat: location.lat, long: location.long));
  }
  @override
  void onPositionUpdated(mp.Position position) {
    mapKey.currentState?.flyTo(
      lat: position.lat.toDouble(),
      lon: position.lng.toDouble(),
    );
  }

}
