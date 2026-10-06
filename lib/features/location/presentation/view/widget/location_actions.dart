import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_list_tile.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/snack_bar.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/presentation/controller/delete_location_cubit.dart';
import 'package:shefaa/features/location/presentation/controller/select_location_cubit.dart';
import 'package:shefaa/features/location/presentation/view/add_location_screen.dart';
import 'package:shefaa/shared/presentation/view/result_screen.dart';

class LocationActions extends StatelessWidget {
  final UserLocationEntity userLocationEntity;
  final void Function(UserLocationEntity l) onLocationUpdated;
  final void Function(UserLocationEntity l) onLocationDeleted;

  const LocationActions({
    super.key,
    required this.userLocationEntity,
    required this.onLocationUpdated,
    required this.onLocationDeleted
  });

  Future<void> _selectLocation(BuildContext context) async {
    await context.read<SelectLocationCubit>().selectLocation(
        userLocationEntity);
    if (context.mounted) context.pop();
  }
  Future<void> _editLocation(BuildContext context) async {
    context.pushNamed(
        Routes.addLocation,
        arguments: AddLocationScreenArgs(
          initial: userLocationEntity,
          onLocationAddedSuccess: (l) {
            context.pushNamedAndRemoveUntil(
              Routes.result,
              arguments: ResultScreenArgs(
                type: ResultType.success,
                message: "تم تعديل عنوان ${l.name ?? l.street} بنجاح، وتم حفظ التغييرات الجديدة.",
                footer: (c) => Column(
                  children: [
                    AppButton.filled(
                      "الى عناوينى",
                      onTap: () => c.pushNamed(Routes.myLocations),
                    ),
                    AppButton.text(
                      align: Alignment.center,
                      "الرئيسية",
                      onTap: () => c.pushNamedAndRemoveUntil(Routes.shell),
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
  Future<void> _deleteLocation(BuildContext context) async {
    await context.read<DeleteLocationCubit>().deleteLocation(
        userLocationEntity.id);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        if (!userLocationEntity.isSelected)
          BaseBlocConsumer<SelectLocationCubit, UserLocationEntity>(
            onLoading: context.loaderOverlay.show,
            onLoaded: (s) {
              context.loaderOverlay.hide();
              if (s.isSuccess) return onLocationUpdated.call(s.data!);
              if (s.isFailure) context.errorBar(s.error!);
            },
            builder: (s) =>
                AppListTile(
                  onTap: () => _selectLocation(context),
                  showLeading: false,
                  title: "اختيار ",
                  showTrailing: false,
                  subtitle: "اختيار العنوان يعني ان يكون العنوان الافتراضي لك",
                ),
          ),
        AppListTile(
          onTap: ()=>_editLocation(context),
          showLeading: false,
          title: "تعديل ",
          showTrailing: false,
        ),
        if (!userLocationEntity.isSelected)
        BaseBlocConsumer<DeleteLocationCubit, Unit>(
          onLoading: context.loaderOverlay.show,
          onLoaded: (s) {
            context.loaderOverlay.hide();
            if (s.isSuccess) return onLocationDeleted.call(userLocationEntity);
            if (s.isFailure) context.errorBar(s.error!);
          },
          builder:(s)=>  AppListTile(
            onTap:()=> _deleteLocation(context),
            showLeading: false,
            title: "حذف ",
            showTrailing: false,
          ),
        ),
      ],
    );
  }
}
