import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/features/booking/data/model/booking.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/data/model/payment.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';

class BookingRemoteDataSource {
  final SupabaseService _supabaseService;

  const BookingRemoteDataSource(this._supabaseService);

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
      filter: (q) => q.select('''
      *,
      doctor:Doctors( *,speciality:Specialties(*), clinic:Clinics(location:Locations(*))),
      clinic:Clinics(*,location:Locations(*)),
      payments:Payments(*)
        '''),
      table: "Appointments",
      page: page,
      mapper: Booking.fromJson,
    );
    return bookings;
  }

  Future<int> createBooking({
    required BookingRequest request,
    required int paymentId,
  }) async {
    final response = await _supabaseService.RPC(
      function: "book_appointment",
      params: {...request.toJson(), "p_payment_id": paymentId},
    );
    return response['id'];
  }
}
