import 'package:flutter/material.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/my_booking_actions.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_card.dart';

class BookingList extends StatelessWidget {
  final bool shrinkWrap;
  final BookingStatus status;
  const BookingList({
    super.key,
    this.status = BookingStatus.upcoming,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.zero,
      itemBuilder: (_, _) => BookingCard(
        status: status,
        footer: MyBookingActions(status: status),
      ),
      separatorBuilder: (_, _) => Gap.medium(),
      itemCount: 12,
    );
  }
}
