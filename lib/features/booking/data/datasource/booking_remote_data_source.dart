import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/features/booking/data/model/booking.dart';
import 'package:shefaa/features/booking/data/model/booking_cancellation.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/data/model/payment.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';

class BookingRemoteDataSource {
  final SupabaseService _supabaseService;

  const BookingRemoteDataSource(this._supabaseService);

  static const String _selectBookingQuery = '''
      *,
      doctor:Doctors( *,speciality:Specialties(*), clinic:Clinics(location:Locations(*))),
      clinic:Clinics(*,location:Locations(*)),
      payments:Payments(*)
        ''' ;

  Future<int> createPayment({
    required PaymentStrategy strategy,
    required num amount,
    num support = 0,
  }) async {
    await strategy.pay(amount: amount + support);
    final response = await _supabaseService.RPC(
      function: "create_payment",
      params: {
        "p_amount": amount,
        "p_support_us_amount": support,
        "p_payment_method": strategy.method.name,
      },
    );
    return Payment.fromJson(response).id;
  }

  Future<PaginationData<Booking>> getAllBooking(int page) async {
    final bookings = await _supabaseService.GET_PAGINATED<Booking>(
      filter: (q) => q.select(_selectBookingQuery).order("created_at", ascending: false),
      table: "Appointments",
      page: page,
      mapper: Booking.fromJson,
    );
    return bookings;
  }

  Future<Booking> createBooking({
    required BookingRequest request,
    required int paymentId,
  }) async {
    final response = await _supabaseService.RPC(
      function: "book_appointment",
      params: {...request.toJson(), "p_payment_id": paymentId},
    );
    return Booking.fromJson(response);
  }

  Future<Booking> updateBooking(
    int id, {
    BookingStatus? status,
    DateTime? time,
    bool? notifyMe,
    BookingCancellation ? cancellation,
    bool? isRated
  }) async {
    final booking = await _supabaseService.UPDATE<Booking>(
      table: "Appointments",
      mapper: Booking.fromJson,
      select: _selectBookingQuery,
      data: {
        "status": status?.name,
        'time': time?.toIso8601String(),
        "notify": notifyMe,
        "cancellation_reason" :cancellation?.toJson(),
        "is_rated":isRated
      }.withoutNulls(),

      idValue: id,
    );

    return booking;
  }

  Future<void> changeBookingDate(
    int bookingId, {
    required DateTime newDate,
  }) async {
    await _supabaseService.UPDATE(
      table: "Appointments",
      data: {"time": newDate.toIso8601String()},
      idValue: bookingId,
    );
  }
}
