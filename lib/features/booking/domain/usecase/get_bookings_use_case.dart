import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/repository/booking_repository.dart';

class GetBookingsUseCase {
  final BookingRepository _repository;
  const GetBookingsUseCase(this._repository);

  Future<PaginationData<BookingEntity>> call(int page) =>
      _repository.getBookings(page);
}
