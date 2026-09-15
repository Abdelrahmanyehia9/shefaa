import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';

extension BookingsEXT on List<BookingEntity> {
  List<BookingEntity> get upcomingBookings =>
      where((e) => e.status.isUpcoming).toList();

  List<BookingEntity> get completedBookings =>
      where((e) => e.status.isCompleted).toList();

  List<BookingEntity> get cancelledBookings =>
      where((e) => e.status.iCancelled).toList();
}
