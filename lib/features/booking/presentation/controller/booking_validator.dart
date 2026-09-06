import 'package:flutter/material.dart';
import 'package:shefaa/core/models/local_time.dart';

class BookingValidator {
  BookingValidator({
    required this.selectDate,
    required this.selectedTime,
  }) {
    selectDate.addListener(_validate);
    selectedTime.addListener(_validate);


    _validate();
  }

  final ValueNotifier<DateTime?> selectDate;
  final ValueNotifier<LocalTime?> selectedTime;


  final ValueNotifier<String?> validationMessage = ValueNotifier(null);

  int _step = 0;

  void setStep(int step) {
    _step = step;
    _validate();
  }
  void validateCurrentStep (){
    _validate();
  }
  void _validate() {
    validationMessage.value = switch (_step) {
      0 => _validateStep0(),
      _ => null,
    };
  }

  String? _validateStep0() {
    if (selectDate.value == null) return "التاريخ والميعاد مطلوب لاتمام الحجز";
    if (selectedTime.value == null) return "من فضلك اختر ميعاد";
    return null;
  }




  void dispose() {
    selectDate.removeListener(_validate);
    selectedTime.removeListener(_validate);
    validationMessage.dispose();
  }
}