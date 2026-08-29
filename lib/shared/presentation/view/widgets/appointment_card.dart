import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppChip(
      paddingHr: UISizes.sp16,
      paddingVr: UISizes.sp16,
      radius: UISizes.r16,
      gradient: LinearGradient(
          colors: [
        context.colors.primary.darken(0.05), context.colors.primary.darken(0.01), context.colors.primary
      ]),
      child: Column(
        spacing: UISizes.h12,
        children: [
          _buildDoctorInfo(context),
          Row(
            spacing: UISizes.w4,
            children: [
              Expanded(
                child: _timeChip(
                  context,
                  icon: AppIcons.calender,
                  text: DateTime.now().toNameOfDayAndMonth(locale: "AR"),
                ),
              ),
              Expanded(
                child: _timeChip(
                  context,
                  icon: AppIcons.time,
                  text: "12:00 PM - 10:00 PM",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _timeChip(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) => AppChip(
    paddingVr: UISizes.h8,
    paddingHr: UISizes.w4,
    color: context.colors.primary.darken(0.2).withAppOpacity(0.5),
    child: AppIconText(
      icon: icon,
      expandedText: true,
      iconSize: UISizes.sp16,
      mainAxisAlignment: MainAxisAlignment.center,
      text: text,
      textStyle: context.textTheme.labelSmall,
      color: context.colors.onPrimary,
    ),
  );
  Widget _buildDoctorInfo(BuildContext context) {
    final color = context.colors.onPrimary;
    final bgColor = context.colors.primary;
    return Row(
      spacing: UISizes.w8,
      children: [
        UserAvatar(
          size: UISizes.sp56,
          color: color,
          image:
              "https://thumbs.dreamstime.com/b/african-american-man-male-doctor-27757329.jpg",
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "د/ وليد النجار",
                style: context.textTheme.titleMedium,
                color: color,
              ),
              AppText(
                "اخصائي رمد",
                style: context.textTheme.bodyMedium,
                color: color,
              ),
            ],
          ),
        ),
        CircleIconButton(
          AppIcons.callFilled,
          padding: UISizes.sp8,
          backgroundColor: color,
          iconColor: bgColor,
        ),
      ],
    );
  }
}
