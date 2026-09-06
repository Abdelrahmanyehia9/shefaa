import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/core/models/local_time.dart';
import 'package:shefaa/features/booking/presentation/controller/booking_validator.dart';

class CreateBookingCubit extends Cubit<BaseState<Unit>> {
  CreateBookingCubit() : super(const BaseState.initial()) {
    validator = BookingValidator(
      selectDate: selectDate,
      selectedTime: selectedTime,
    );
  }

  final ValueNotifier<DateTime?> selectDate = ValueNotifier(null);
  final ValueNotifier<LocalTime?> selectedTime = ValueNotifier(null);


  late final BookingValidator validator;

  int currentStep = 0;

  void setStep(int step) {
    currentStep = step;
    validator.setStep(step);
  }

  void createBooking() {}

  @override
  Future<void> close() {
    validator.dispose();
    selectDate.dispose();
    selectedTime.dispose();
    return super.close();
  }
}