import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/overlay/bottom_sheets.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/presentation/controller/delete_location_cubit.dart';
import 'package:shefaa/features/location/presentation/controller/select_location_cubit.dart';
import 'package:shefaa/features/location/presentation/controller/get_all_locations_cubit.dart';
import 'package:shefaa/features/location/presentation/view/widget/location_actions.dart';

class LocationCard extends StatelessWidget {
  final UserLocationEntity location;

  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = location.isSelected;
    return Stack(
      alignment: AlignmentGeometry.topEnd,
      children: [
        AppClick(
          onTap: () {
            BottomSheets.show(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (c) => sl<SelectLocationCubit>()),
                  BlocProvider(create: (c) => sl<DeleteLocationCubit>()),
                ],
                child: LocationActions(
                  onLocationUpdated: (l) {
                    context.read<GetAllLocationsCubit>().selectLocation(l.id);
                  },
                  onLocationDeleted: (l){
                    context.read<GetAllLocationsCubit>().getAllLocations();

                  },
                  userLocationEntity: location,
                ),
              ),
            );
          },
          child: Card(
            shape: OutlineInputBorder(
              borderSide: isSelected
                  ? BorderSide(
                      color: context.colors.primary,
                      width: UISizes.sp1,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(UISizes.r12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  isSelected? location.name.isNullOrEmpty ? "بدون اسم" : location.name : null,
                  style: context.textTheme.headlineSmall,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        location.street,
                        style: context.textTheme.labelSmall,
                        color: context.colors.surfaceContainer,
                      ),
                    ),

                    AppText(
                      '${location.government} | ${location.area}',
                      style: context.textTheme.labelSmall,
                      color: context.colors.primary,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _item(context, location.build, 'البناية'),
                    _divider(context),
                    _item(context, location.flatNo, 'شقة'),
                    _divider(context),
                    _item(context, location.floor, 'الدور'),
                  ],
                ),
              ],
            ).paddingAll,
          ),
        ),
        if (isSelected)
          Icon(
            AppIcons.checkedFilled,
            color: context.colors.primary,
          ).appPaddingAll(8),
      ],
    );
  }

  Widget _item(BuildContext context, String value, String label) => AppIconText(
    reverse: true,
    text: label,
    textStyle: context.textTheme.labelMedium,
    customIcon: AppText(value, style: context.textTheme.titleMedium),
  );

  Widget _divider(BuildContext context) => AppText(
    '|',
    style: context.textTheme.labelLarge,
    color: context.colors.surfaceContainerLow,
  );
}
