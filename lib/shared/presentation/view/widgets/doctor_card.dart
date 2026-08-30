import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_rating_stars.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_widget_overlay.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/shared/domain/entity/rate_entity.dart';
import 'package:shefaa/features/favorite/presentation/view/widgets/app_favorite_button.dart';

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return AppWidgetOverlay(
      overlay: [
        (
          AlignmentGeometry.topEnd,
          AppFavoriteButton(
            favorite: doctor,
            color: context.colors.surfaceContainer,
            bgColor: Colors.transparent,
          ).appPaddingAll(8),
        ),
      ],
      child: AppClick(
        onTap: () => context.pushNamed(Routes.doctor),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(UISizes.r14),
            side: BorderSide(
              width: 0.5,
              color: context.colors.surfaceContainerLowest,
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              spacing: UISizes.w8,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppCachedNetworkImage(
                  doctor.image,
                  height: UISizes.h80,
                  width: UISizes.w80,
                  radius: UISizes.r14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppChip(
                        monochromatic: true,
                        paddingVr: UISizes.sp2,
                        child: AppIconText(
                          icon: AppIcons.locationFilled,
                          iconSize: UISizes.sp16,
                          gap: UISizes.sp2,
                          color: context.colors.primary,
                          text: "3 كم",
                          textStyle: context.textTheme.titleSmall,
                        ),
                      ),
                      Gap.extraSmall(),
                      AppText(
                        "د/ ${doctor.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelMedium,
                      ),

                      AppText(
                        doctor.speciality,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall,
                        color: context.colors.surfaceContainer,
                      ),
                      Gap.extraSmall(),
                      _DoctorRatingRow(rating: doctor.rate),
                    ],
                  ),
                ),
              ],
            ),
          ).appPaddingAll(8),
        ),
      ),
    );
  }
}

class _DoctorRatingRow extends StatelessWidget {
  final RateEntity rating;
  const _DoctorRatingRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w4,
      children: [
        AppRatingStars(rating: rating.value, size: UISizes.sp14),
        AppText(
          "${rating.value}",
          style: context.textTheme.titleSmall,
          height: 0,
        ),
        AppText(
          "|",
          style: context.textTheme.bodyLarge,
          height: 0,
          color: context.colors.surfaceContainer,
        ).appPaddingHr(4),
        Expanded(
          child: AppText(
            height: 0,
            "${rating.count.compactNumber} مراجعة",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall,
            color: context.colors.surfaceContainer,
          ),
        ),
      ],
    );
  }
}
