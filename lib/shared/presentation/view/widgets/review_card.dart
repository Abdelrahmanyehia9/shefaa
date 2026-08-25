import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/core/utils/time_message.dart';

class ReviewCard extends StatelessWidget {
  final bool hasMedia;
  const ReviewCard({super.key, this.hasMedia = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h8,
      children: [
        const _Reviewer(),
        AppText(
          style: context.textTheme.bodyMedium,
          "هذا الدكتور رائع ومستمع لى وكتبلى على وصفة ادوية لقد شفيت بسبب خبرة تلك الطبيب",
        ),
        if (hasMedia) const _ReviewMedia(),
      ],
    );
  }
}

class _Reviewer extends StatelessWidget {
  const _Reviewer();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w8,
      children: [
        UserAvatar(size: UISizes.sp40, color: context.colors.primary),
        AppText("محمد خالد", style: context.textTheme.labelMedium),
        const Spacer(),
        _buildRateAndTime(context),
      ],
    );
  }

  Widget _buildRateAndTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppIconText(
          icon: AppIcons.starFilled,
          iconColor: AppColors.gold,
          iconSize: UISizes.sp16,
          textStyle: context.textTheme.titleSmall,
          text: "4.5",
        ),
        AppText(
          DateTime.now()
              .subtract(const Duration(days: 234))
              .timeAgo(messages: const TimeMessagesAr()),
          style: context.textTheme.bodySmall,
          color: context.colors.surfaceContainer,
          height: 0,
        ),
      ],
    );
  }
}

class _ReviewMedia extends StatelessWidget {
  const _ReviewMedia();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UISizes.h96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, _) => const AppCachedNetworkImage(null),
        separatorBuilder: (_, _) => HGap.small(),
        itemCount: 4,
      ),
    );
  }
}
