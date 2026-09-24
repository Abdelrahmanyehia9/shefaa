import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/enum/review_type.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/review/domain/usecase/review_booking_use_case.dart';
import 'package:shefaa/features/review/presentation/controller/review_controller.dart';

class ReviewBookingCubit extends Cubit<BaseState<Unit>> {
  final ReviewBookingUseCase _useCase;
  ReviewBookingCubit(this._useCase) : super(const .initial());

  Future<void> giveReview(
    BookingEntity booking,
    Map<ReviewType, ReviewController> reviewController,
  ) async {
    safeEmit(const .loading());
    final result = await _useCase.call(
      booking,
      docReview: reviewController[ReviewType.doctor]?.toRequest(),
      clinicReview: reviewController[ReviewType.clinic]?.toRequest(),
      staffReview: reviewController[ReviewType.clinic]?.toRequest(),
    );
    result.fold((e) => safeEmit(.failure(e)), (s) => safeEmit(.success(s)));

  }
}
