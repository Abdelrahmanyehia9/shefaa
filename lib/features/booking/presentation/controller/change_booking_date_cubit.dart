import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/usecase/change_booking_date_use_case.dart';

class ChangeBookingDateCubit extends Cubit<BaseState<BookingEntity>> {
  final ChangeBookingDateUseCase _useCase;

  ChangeBookingDateCubit(this._useCase) : super(const .initial());

  Future<void> changeDate(int bookId, {required DateTime newDate}) async {
    safeEmit(const .loading());
    final result = await _useCase.call(bookId, newDate: newDate);
    result.fold((e) => safeEmit(.failure(e)), (s) => safeEmit(.success(s)));
  }
}