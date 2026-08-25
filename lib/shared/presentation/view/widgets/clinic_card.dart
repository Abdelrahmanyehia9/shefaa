import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_widget_overlay.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_favorite_button.dart';

class ClinicCard extends StatelessWidget {
  const ClinicCard({super.key});

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
              const _ClinicInfo().appPaddingAll(8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClinicThumb(double height, double width) => AppWidgetOverlay(
    overlay: [
      (AlignmentGeometry.topEnd, const AppFavoriteButton().appPaddingAll(4)),
      (AlignmentGeometry.bottomEnd, const _RatingChip()),
    ],
    child: AppCachedNetworkImage(null, height: height, width: width),
  );
}

class _RatingChip extends StatelessWidget {
  const _RatingChip();

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
        text: "4.8",
        textStyle: context.textTheme.labelSmall,
      ),
    ).appPaddingAll(4);
  }
}

class _ClinicInfo extends StatelessWidget {
  const _ClinicInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          "عيادة هيريكا للشعر",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelMedium,
        ),
        AppIconText(
          icon: AppIcons.timeFilled,
          iconSize: UISizes.sp16,
          textStyle: context.textTheme.bodySmall,
          color: context.colors.surfaceContainer,
          text: "15 د  ●  2.5 كم",
        ),
      ],
    );
  }
}
