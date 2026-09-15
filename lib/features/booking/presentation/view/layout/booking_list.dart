import 'package:flutter/material.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/my_booking_actions.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_card.dart';

class BookingList extends StatelessWidget {
  final bool shrinkWrap;
  final List<BookingEntity> bookings;
  final ScrollController? controller;
  const BookingList({
    super.key,
    this.bookings = const [],
    this.shrinkWrap = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.zero,
      itemBuilder: (_, i) => BookingCard(
        booking: bookings[i],
        footer: MyBookingActions(booking: bookings[i]),
      ),
      separatorBuilder: (_, _) => Gap.medium(),
      itemCount: bookings.length,
    );
  }
}
