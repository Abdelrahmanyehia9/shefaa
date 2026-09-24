import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';


class MyBookingActions extends StatelessWidget {
  final BookingEntity booking;

  const MyBookingActions({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = booking.status.isUpcoming;
    final isCancelled = booking.status.iCancelled;
    final isRated = booking.isRated;

    final primaryText = isUpcoming
        ? "تغيير الميعاد"
        : isCancelled
        ? "اعادة الحجز"
        : isRated
        ? "تم التقييم"
        : "اضافة تقييم";

    final secondaryText = isUpcoming ? "الغاء الحجز" : "حجز تانى";

    return Row(
      spacing: UISizes.w8,
      children: [
        Expanded(
          child: AppButton.filled(
            primaryText,
            isDisabled: !isUpcoming && isRated,
            padding: EdgeInsets.zero,
            fixedSize: Size(double.infinity, UISizes.h40),
            onTap: () {
              if (isUpcoming) {
                onReschedule(context);
              } else if (isCancelled) {
                onRebook(context);
              } else {
                onRating(context);
              }
            },
          ),
        ),
        if (!isCancelled)
          Expanded(
            child: AppButton.outlined(
              secondaryText,
              fixedSize: Size(double.infinity, UISizes.h40),
              color: context.colors.primary,
              onTap: () {
                if (isUpcoming) {
                  onCancel(context);
                } else {
                  onRebook(context);
                }
              },
            ),
          ),
      ],
    );
  }

  void onRating(BuildContext context) {
    context.pushNamed(Routes.rateBooking, arguments: booking);
  }

  void onCancel(BuildContext context) {
    context.pushNamed(Routes.cancelBooking, arguments: booking);
  }

  void onReschedule(BuildContext context) {
    context.pushNamed(Routes.rescheduleBooking, arguments: booking);
  }

  void onRebook(BuildContext context) {
    context.pushNamed(Routes.doctor, arguments: booking.doctor);
  }
}


 