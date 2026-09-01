import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/core/utils/time_message.dart';
import 'package:shefaa/features/review/domain/entity/review_entity.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';

class ReviewCard extends StatelessWidget {
  final ReviewEntity review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Reviewer(review.reviewer),
            _RateAndTime(rate: review.rate, createdAt: review.createdAt),
          ],
        ),
        AppText(style: context.textTheme.bodyMedium, review.comment),
      ],
    );
  }
}

class _Reviewer extends StatelessWidget {
  final UserEntity reviewer;
  const _Reviewer(this.reviewer);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w8,
      children: [
        UserAvatar(
          size: UISizes.sp40,
          color: context.colors.primary,
          image: reviewer.profilePic,
        ),
        AppText(
          reviewer.isYou ? "انت" : reviewer.completeName,
          style: context.textTheme.labelMedium,
        ),
      ],
    );
  }
}

class _RateAndTime extends StatelessWidget {
  final DateTime createdAt;
  final double rate;
  const _RateAndTime({required this.rate, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppIconText(
          icon: AppIcons.starFilled,
          iconColor: AppColors.gold,
          iconSize: UISizes.sp16,
          textStyle: context.textTheme.titleSmall,
          text: rate.toStringAsFixed(1),
        ),
        AppText(
          createdAt.timeAgo(messages: const TimeMessagesAr()),
          style: context.textTheme.bodySmall,
          color: context.colors.surfaceContainer,
          height: 0,
        ),
      ],
    );
  }
}
