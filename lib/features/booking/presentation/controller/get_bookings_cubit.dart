import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/usecase/get_bookings_use_case.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_mixin.dart';

class GetBookingsCubit extends Cubit<BaseState<PaginationData<BookingEntity>>>
    with PaginatedMixin<BookingStatus?, BookingEntity> {
  final GetBookingsUseCase _useCase;
  GetBookingsCubit(this._useCase) : super(const .initial());
  @override
  Future<PaginationData<BookingEntity>> fetchPage(
    BookingStatus? key,
    int page, {
    bool forceRefresh = false,
  }) async {
    return await _useCase.call(page);
  }

  @override
  void onLoading() => safeEmit(const .loading());

  @override
  void onSuccess(PaginationData<BookingEntity> data) =>
      safeEmit(.success(data));


  Future<void> cancelBooking(BookingEntity booking) async {
    final currentData = state.successDataOrNull;
    if (currentData == null) return;
    final updated = currentData.updateItem(
          (b) => b == booking,
          (b) => b.copyWith(status: BookingStatus.cancelled),
    );
    safeEmit(.success(updated));
  }
  Future<void> updateBookingTime(int bookingId,{required DateTime time}) async {
    final currentData = state.successDataOrNull;
    if (currentData == null) return;
    final updated = currentData.updateItem(
          (b) => b.id == bookingId,
          (b) => b.copyWith(time: time),
    );
    safeEmit(.success(updated));
  }

  @override
  bool get enableCache => true;
}
