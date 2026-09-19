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

    return Row(
      spacing: UISizes.w8,
      children: [
        Expanded(
          child: AppButton.filled(
            padding: EdgeInsets.zero,
            fixedSize: Size(double.infinity, UISizes.h40),
            isUpcoming
                ? "تغيير الميعاد"
                : isCancelled
                ? "اعادة الحجز"
                : "اضافة تقييم",
            onTap: isUpcoming
                ? ()=>onReschedule(context)
                : isCancelled
                ? ()=>onRebook(context)
                : ()=>onRating(context),
          ),
        ),
        if (!isCancelled)
          Expanded(
            child: AppButton.outlined(
              fixedSize: Size(double.infinity, UISizes.h40),
              isUpcoming ? "الغاء الحجز" : "حجز تانى",
              color: context.colors.primary,
              onTap: isUpcoming ? ()=>onCancel(context) : ()=>onRebook(context),
            ),
          ),
      ],
    );
  }
  
  Future<void> onRating(BuildContext context)async{
    context.pushNamed(Routes.rateBooking, arguments: booking) ;
  }
  Future<void> onCancel(BuildContext context) async {
    context.pushNamed(Routes.cancelBooking, arguments: booking) ;
 }
  Future<void>onReschedule(BuildContext context)async {
  context.pushNamed(Routes.rescheduleBooking, arguments: booking);

  } 
  Future<void> onRebook (BuildContext context)async{
    context.pushNamed(Routes.doctor, arguments: booking.doctor);

  }
}

 