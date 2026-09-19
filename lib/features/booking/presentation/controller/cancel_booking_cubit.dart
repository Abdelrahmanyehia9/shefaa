import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/enum/cancel_reason_type.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/usecase/cancel_booking_use_case.dart';

class CancelBookingCubit extends Cubit<BaseState<BookingEntity>> {
  final CancelBookingUseCase _useCase;

  CancelBookingCubit(this._useCase) : super(const .initial());

  Future<void> cancelBooking(int bookId, {required CancelReasonType reason , String? extraInfo}) async {
    safeEmit(const .loading());
    final result = await _useCase.call(bookId,reason: reason, extra: extraInfo);
    result.fold((e) => safeEmit(.failure(e)), (s) => safeEmit(.success(s)));
  }
}
