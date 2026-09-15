import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';

class MyBookingActions extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback? onReschedule;
  final VoidCallback? onCancel;
  final VoidCallback? onRating;
  final VoidCallback? onRebook;

  const MyBookingActions({
    super.key,
    required this.booking,
    this.onReschedule,
    this.onCancel,
    this.onRating,
    this.onRebook,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = booking.status.isUpcoming;
    final isCancelled = booking.status.iCancelled;

    return Row(
      spacing: UISizes.w8,
      children: [
        Expanded(
          child: AppButton.filled(
            isUpcoming
                ? "تغيير الميعاد"
                : isCancelled
                ? "اعادة الحجز"
                : "اضافة تقييم",
            onTap: isUpcoming
                ? onReschedule
                : isCancelled
                ? onRebook
                : onRating,
          ),
        ),
        if (!isCancelled)
          Expanded(
            child: AppButton.outlined(
              isUpcoming ? "الغاء الحجز" : "حجز تانى",
              color: context.colors.primary,
              onTap: isUpcoming ? onCancel : onRebook,
            ),
          ),
      ],
    );
  }
}
