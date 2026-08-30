import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_widget_overlay.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/favorite/presentation/view/widgets/app_favorite_button.dart';

class ClinicCard extends StatelessWidget {
  final ClinicEntity clinic;
  const ClinicCard({super.key, required this.clinic});

  static Size cardSize = Size(UISizes.w220, UISizes.h196);

  @override
  Widget build(BuildContext context) {
    final width = cardSize.width;
    final height = cardSize.height;
    return AppClick(
      onTap: () => context.pushNamed(Routes.clinic),
      child: Card(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildClinicThumb(height * .6, context.width),
              _ClinicInfo(
                name: clinic.name,
                waitingTime: clinic.waitingTimeInMin,
                location: clinic.location,
              ).appPaddingAll(8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClinicThumb(double height, double width) => AppWidgetOverlay(
    overlay: [
      (
        AlignmentGeometry.topEnd,
        AppFavoriteButton(favorite: clinic).appPaddingAll(4),
      ),
      (AlignmentGeometry.bottomEnd, _RatingChip(clinic.rate)),
    ],
    child: AbsorbPointer(
      child: AppCachedNetworkImage(
        clinic.image,
        color: AppColors.black.withAppOpacity(0.075),
        colorBlendMode: BlendMode.srcATop,
        height: height,
        width: width,
      ),
    ),
  );
}

class _RatingChip extends StatelessWidget {
  final double rating;
  const _RatingChip(this.rating);

  @override
  Widget build(BuildContext context) {
    return AppChip(
      paddingVr: UISizes.sp1,
      paddingHr: UISizes.sp4,
      color: AppColors.white,
      radius: UISizes.r8,
      child: AppIconText(
        iconSize: UISizes.sp16,
        gap: UISizes.sp2,
        icon: AppIcons.starFilled,
        iconColor: AppColors.gold,
        text: rating.toString(),
        textStyle: context.textTheme.labelSmall,
        color: AppColors.black,
      ),
    ).appPaddingAll(4);
  }
}

class _ClinicInfo extends StatelessWidget {
  final String name;
  final int waitingTime;
  final String? location;
  const _ClinicInfo({
    required this.name,
    required this.waitingTime,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelMedium,
        ),
        AppIconText(
          icon: AppIcons.timeFilled,
          iconSize: UISizes.sp16,
          text:
              '$waitingTime د ${!location.isNullOrEmpty ? '\t\t\t● $location' : ''}',
          textStyle: context.textTheme.bodySmall,
          color: context.colors.surfaceContainer,
        ),
      ],
    );
  }
}
