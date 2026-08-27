import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_clinic_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_doctor_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_select_date.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_select_time.dart';

class BookingFormV1 extends StatelessWidget {
  const BookingFormV1({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppStaggeredAnimation(
      children: [
        BookingDoctorInfo(),
        BookingClinicInfo(),
        BookingSelectDate(),
        BookingSelectTime(),
      ],
    );
  }
}
