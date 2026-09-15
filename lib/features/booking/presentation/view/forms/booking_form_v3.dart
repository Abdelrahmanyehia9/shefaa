import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/features/booking/domain/entity/booking_options_entity.dart';
import 'package:shefaa/features/booking/presentation/controller/support_us_controller.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_amount_to_pay.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_choose_payment_method.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_support_us.dart';

class BookingFormV3 extends StatefulWidget {
  final BookingOptionsEntity options;
  final SupportUsController controller;
  const BookingFormV3({
    super.key,
    required this.options,
    required this.controller,
  });

  @override
  State<BookingFormV3> createState() => _BookingFormV3State();
}

class _BookingFormV3State extends State<BookingFormV3> {
  final ScrollController _scrollController = ScrollController();
  void scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: AppStaggeredAnimation(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: widget.controller,
            builder: (_, _) => BookingAmountToPay(
              toPay:
                  widget.options.consultFees + (widget.controller.amount ?? 0),
            ),
          ),
          const BookingChoosePaymentMethod(),
          BookingSupportUs(
            onCustomAmount: scrollToEnd,
            controller: widget.controller,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
