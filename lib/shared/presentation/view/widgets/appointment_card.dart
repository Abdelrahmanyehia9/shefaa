import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';

class AppointmentCard extends StatelessWidget {
  final BookingEntity booking ;
  const AppointmentCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return AppChip(
      paddingHr: UISizes.sp12,
      paddingVr: UISizes.sp16,
      radius: UISizes.r16,
      color: context.colors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: UISizes.h8,
        children: [
          _buildDoctorInfo(context),
          Row(
            spacing: UISizes.w4,
            children: [
              Expanded(
                flex: 3,
                child: _timeChip(
                  context,
                  icon: AppIcons.calender,
                  text: booking.time.toNameOfDayAndMonth(locale: "AR"),
                ),
              ),
              Expanded(
                flex: 2,
                child: _timeChip(
                  context,
                  icon: AppIcons.time,
                  text: booking.time.time12Only(locale: "AR"),
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
    color: context.colors.primary.darken().withAppOpacity(0.7),
    child: AppIconText(
      icon: icon,
      iconSize: UISizes.sp16,
      mainAxisAlignment: MainAxisAlignment.center,
      text: text,
      textStyle: context.textTheme.labelMedium,
      color: context.colors.onPrimary,
    ),
  );
  Widget _buildDoctorInfo(BuildContext context) {
    final color = context.colors.onPrimary;
    return Row(
      spacing: UISizes.w8,
      children: [
        UserAvatar(size: UISizes.sp56,
        image: booking.doctor.image,color: color,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "د/ ${booking.doctor.name}",
                style: context.textTheme.titleMedium,
                color: color,
              ),
              AppText(
                booking.doctor.doctorTitle,
                style: context.textTheme.bodyMedium,
                color: color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
