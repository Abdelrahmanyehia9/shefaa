import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_click.dart';
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

class AddLocationFormV1 extends StatefulWidget {
  final VoidCallback? onSkip ;
  final void Function(LatLong ll)onLocationPicked ;
  final LatLong? initial  ;
  const AddLocationFormV1({super.key, this.initial, this.onSkip, required this.onLocationPicked});

  @override
  State<AddLocationFormV1> createState() => _AddLocationFormV1State();
}

class _AddLocationFormV1State extends State<AddLocationFormV1>
    with GeoLocatorMixin, AutomaticKeepAliveClientMixin {
  static const _permission = AppPermission.location;
  final mapKey = GlobalKey<MapViewState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final i = widget.initial;
    if (i != null) position = mp.Position(i.long, i.lat);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PermissionConsumer(
      permission: _permission,
      onGranted: () => moveToUser(widget.initial),
      deniedBuilder: widget.initial == null
          ? PermissionRequiredView(
        permission: _permission,
        actions: (c) => [
          AppButton.filled(
            "منح الصلاحية",
            onTap: () => c.read<PermissionCubit>().request(_permission),
          ),
          if (widget.onSkip != null)
            AppButton.text(
              "تخطي",
              align: Alignment.center,
              onTap: widget.onSkip,
            ),
        ],
      ).paddingAll
          : null,

      builder: (s, c) {
        if (position == null) {
          return _buildPlaceHolder();
        }
        return Column(
          children: [
            Expanded(child: MapView(key: mapKey, initialPoint: position)),
            AppClick(
              animate: false,
              onTap: _onLocationPicked,
              child: AbsorbPointer(
                child: AppButton.filled(
                  "تاكيد",
                  fixedSize: Size(context.width, UISizes.sp40 + context.safeBottomArea),
                  padding: EdgeInsets.only(bottom: context.safeBottomArea),
                  radius: 0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlaceHolder() => Stack(
    alignment: AlignmentDirectional.center,
    children: [
      Image.asset(
        AppAssets.mapPlaceHolder,
        color: Colors.white30,
        colorBlendMode: BlendMode.srcATop,
        fit: BoxFit.cover,
        width: double.infinity,
        height: context.height,
      ),
      AppLoader(backgroundColor: Colors.transparent, size: UISizes.sp164),
    ],
  );

  Future<void> _onLocationPicked() async {
    final loc = await mapKey.currentState?.getSelectedLocation();
    final p = position;
    final lat = loc?.lat ?? p?.lat.toDouble();
    final long = loc?.lng ?? p?.lng.toDouble();
    if (!mounted || lat == null || long == null) return;
    widget.onLocationPicked(LatLong(lat: lat, long: long));
  }

  @override
  void onPositionUpdated(mp.Position position) {
    mapKey.currentState?.flyTo(
      lat: position.lat.toDouble(),
      lon: position.lng.toDouble(),
    );
  }
}