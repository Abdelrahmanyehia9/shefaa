import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_amount_to_pay.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_choose_payment_method.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_support_us.dart';

class BookingFormV3 extends StatelessWidget {
  const BookingFormV3({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: AppStaggeredAnimation(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookingAmountToPay(),

          BookingChoosePaymentMethod(),
          BookingSupportUs(),
        ],
      ),
    );
  }
}
