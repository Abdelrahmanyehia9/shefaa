import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_rating_stars.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_highlight.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class DoctorHeader extends StatelessWidget {
  const DoctorHeader({super.key, this.showClinicName = true, this.heroTag});

  final bool showClinicName;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final avatar = UserAvatar(
      size: UISizes.sp84,
      image:
          "https://thumbs.dreamstime.com/b/african-american-man-male-doctor-27757329.jpg",
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: UISizes.h8,
      children: [
        Row(
          spacing: UISizes.w8,
          children: [
            if (heroTag case final tag?)
              Hero(tag: tag, child: avatar)
            else
              avatar,

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _DoctorDetails(showClinicName: showClinicName),
                  const _DoctorRating(),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
        const _DoctorInfo(),
      ],
    );
  }
}

class _DoctorDetails extends StatelessWidget {
  const _DoctorDetails({required this.showClinicName});

  final bool showClinicName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText("دكتور خالد احمد", style: context.textTheme.labelLarge),
              AppText("استشارى قلب", style: context.textTheme.bodySmall),
            ],
          ),
        ),
        if (showClinicName)
          AppIconText(
            icon: AppIcons.clinic,
            iconSize: UISizes.sp16,
            textStyle: context.textTheme.titleSmall,
            color: context.colors.primary,
            text: "عيادة الحياه",
          ),
      ],
    );
  }
}

class _DoctorRating extends StatelessWidget {
  const _DoctorRating();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w4,
      children: [
        const AppRatingStars(rating: 2.6),
        Expanded(
          child: AppTextHighLight(
            "(التقييم من *124* مراجعة)",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.surfaceContainer,
            ),
            highlighterStyle: context.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _DoctorInfo extends StatelessWidget {
  const _DoctorInfo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _item(context, text: "وقت الانتظار 11 د", icon: AppIcons.time),
        ),
        _divider(context),
        Expanded(
          child: _item(context, text: "الكشف 300 جنيه", icon: AppIcons.wallet),
        ),
      ],
    );
  }

  Widget _divider(BuildContext context) => Container(
    height: UISizes.sp32,
    width: UISizes.sp1,
    color: context.colors.surfaceContainerLowest,
  );

  Widget _item(
    BuildContext context, {
    required String text,
    required IconData icon,
  }) => AppIconText(
    text: text,
    icon: icon,
    iconColor: context.colors.primary,
    textStyle: context.textTheme.labelMedium,
    iconSize: UISizes.sp18,
  );
}
