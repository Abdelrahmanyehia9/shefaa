import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class BookingActions extends StatelessWidget {
  final BookingStatus status;
  final VoidCallback? onReschedule;
  final VoidCallback? onCancel;
  final VoidCallback? onRating;
  final VoidCallback? onRebook;

  const BookingActions({
    super.key,
    required this.status,
    this.onReschedule,
    this.onCancel,
    this.onRating,
    this.onRebook,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = status.isUpcoming;
    final isCancelled = status.iCancelled;

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
