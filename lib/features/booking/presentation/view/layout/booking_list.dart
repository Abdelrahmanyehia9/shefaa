import 'package:flutter/material.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/my_booking_actions.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_card.dart';

class BookingList extends StatelessWidget {
  final bool shrinkWrap;
  final List<BookingEntity> bookings;
  final ScrollController? controller;
  final Widget? header;
  final Widget? footer;

  const BookingList({
    super.key,
    this.bookings = const [],
    this.shrinkWrap = false,
    this.controller,
    this.header,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final count =
        bookings.length + (header != null ? 1 : 0) + (footer != null ? 1 : 0);
    return ListView.separated(
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.zero,
      itemCount: count,
      itemBuilder: (_, index) {
        if (header != null && index == 0) return header!;
        final bookingIndex = index - (header != null ? 1 : 0);
        if (bookingIndex >= bookings.length) return footer!;
        final booking = bookings[bookingIndex];
        return BookingCard(
          booking: booking,
          footer: MyBookingActions(booking: booking,
          ),
        );
      },
      separatorBuilder: (_, _) => Gap.medium(),
    );
  }
}
