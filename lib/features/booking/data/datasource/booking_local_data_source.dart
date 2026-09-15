import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/booking/data/model/booking.dart';

class BookingLocalDataSource {
  Future<PaginationData<Booking>?> getBookings() async {
    return null;
  }

  Future<void> saveToLocal(List<Booking> bookings) async {
    return;
  }
}
