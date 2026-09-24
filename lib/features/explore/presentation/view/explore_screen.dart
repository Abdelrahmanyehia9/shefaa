import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_loader.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/enum/app_permission.dart';
import 'package:shefaa/core/extensions/camera_state_ext.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/explore/presentation/controllers/get_nearby_clinic_cubit.dart';
import 'package:shefaa/features/explore/presentation/mixin/explore_map_mixin.dart';
import 'package:shefaa/features/location/presentation/view/widget/map_view.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/shared/presentation/controllers/permission_cubit.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/search_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/permission_consumer.dart';
import 'package:shefaa/shared/presentation/view/widgets/permission_required_view.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with ExploreMapMixin {
  static const permission = AppPermission.location;
  PermissionCubit get permissionCubit => context.read<PermissionCubit>();

  @override
  void initState() {
    super.initState();
    permissionCubit.request(permission);
  }

  Future<void> getNearbyClinics({
    required num lat,
    required num lng,
    required num? zoom
  }) async => await context.read<GetNearbyClinicCubit>().getNearbyClinics(
      LatLong(lat: lat.toDouble(), long: lng.toDouble()),
      zoom?.toDouble()
    );

  @override
  void dispose() {
    disposeExploreMap();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PermissionConsumer(
      permission: permission,
      deniedBuilder: PermissionRequiredView(
        permission: permission,
        actions: (c) => [
          AppButton.filled(
            "السماح بالوصول",
            onTap: () => permissionCubit.request(permission),
          ),
        ],
      ).paddingHr,
      onGranted: () async {
        await moveToUser();
        if (position != null) {
          await getNearbyClinics(
            lat: position!.lat,
            lng: position!.lng,
            zoom: null
          );
        }
      },
      builder: (c, s) => Stack(
        fit: StackFit.expand,
        children: [
          if (position == null)
            AppLoader(backgroundColor: Colors.transparent, size: UISizes.sp196)
          else ...[
            BaseBlocConsumer<
              GetNearbyClinicCubit,
              PaginationData<ClinicEntity>
            >(
              builder: (s) {
                return MapView(
                  key: mapKey,
                  markers: s.isSuccess ? s.data!.data.map((e)=>MapMarker(id: e.id.toString(), latitude: e.location.lat, longitude: e.location.long)).toList()  : [],
                  onCameraIdle: (state) {
                    final center = state.center.coordinates;
                    final radiusKm = state.zoomToRadius(
                      MediaQuery.sizeOf(context),
                    );
                    getNearbyClinics(
                      lat: center.lat,
                      lng: center.lng,
                      zoom: radiusKm,
                    );
                  },
                  onMovingChanged: onMovingChanged,
                  goingToUserLocation: () => flyToPosition(position),
                  initialPoint: mp.Point(coordinates: position!),
                  controllersBottom: context.safeBottomArea + UISizes.h16 + 180,
                  onMarkerTap: (_) {},
                  onUserLocationUpdated: (_) {},
                );
              },
            ),
            Positioned(
              top: context.safeTopArea + UISizes.h16,
              left: UISizes.w16,
              right: UISizes.w16,
              child: SearchField(height: UISizes.h48),
            ),
            // Positioned(
            //   left: UISizes.w16,
            //   right: UISizes.w16,
            //   bottom: context.safeBottomArea + UISizes.h16,
            //   child: ValueListenableBuilder<bool>(
            //     valueListenable: isMoving,
            //     builder: (_, moving, child) => IgnorePointer(
            //       ignoring: moving,
            //       child: AnimatedSlide(
            //         offset: Offset(0, moving ? 1.5 : 0),
            //         duration: const Duration(milliseconds: 500),
            //         curve: Curves.easeInOut,
            //         child: child,
            //       ),
            //     ),
            //     child: ClinicList(clinics: clinics),
            //   ),
            // ),
          ],
        ],
      ),
    );
  }
}
