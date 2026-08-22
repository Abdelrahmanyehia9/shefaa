import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_rating_stars.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_widget_overlay.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_favorite_button.dart';


class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppWidgetOverlay(
      overlay: [
        (
          AlignmentGeometry.topEnd,
          AppFavoriteButton(
            color: context.colors.surfaceContainer,
            bgColor: Colors.transparent,
          ).appPaddingAll(8),
        ),
      ],
      child: Card(
        child: IntrinsicHeight(
          child: Row(
            spacing: UISizes.w8,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCachedNetworkImage(
                "https://thumbs.dreamstime.com/b/african-american-man-male-doctor-27757329.jpg",
                height: UISizes.h128,
                width: UISizes.w96,
                radius: UISizes.r12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppChip(
                      color: AppColors.primary,
                      monochromatic: true,
                      paddingVr: UISizes.sp2,
                      child: AppIconText(
                        icon: AppIcons.verifiedCircleFilled,
                        iconSize: UISizes.sp16,
                        gap: UISizes.sp2,
                        color: AppColors.primary,
                        text: "دكتور موثق",
                        textStyle: context.textTheme.titleSmall,
                      ),
                    ),
                    Gap.extraSmall(),
                    AppText(
                      "د/ عبدالرحمن عبدالسميع",
                      height: 0,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelMedium,
                    ),
                    AppText(
                      "اخصائي رمد وعمليات تجميل الابصار والليزك",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall,
                    ),
                    Gap.extraSmall(),
                    const _DoctorRatingRow(rating: 4.6, reviewsCount: 534),
                  ],
                ),
              ),
            ],
          ),
        ).paddingAll,
      ),
    );
  }
}

class _DoctorRatingRow extends StatelessWidget {
  const _DoctorRatingRow({required this.rating, required this.reviewsCount});

  final double rating;
  final int reviewsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w4,
      children: [
        AppRatingStars(rating: rating, size: UISizes.sp14),
        AppText("$rating", style: context.textTheme.titleSmall, height: 0),
        AppText(
          "|",
          style: context.textTheme.bodyLarge,
          height: 0,
          color: context.colors.surfaceContainer,
        ).appPaddingHr(4),
        Expanded(
          child: AppText(
            height: 0,
            "${reviewsCount.compactNumber} مراجعة",
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
