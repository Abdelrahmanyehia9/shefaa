import 'package:flutter/material.dart';
import 'package:shefaa/core/helper/app_validation.dart';
import 'package:shefaa/features/booking/presentation/controller/booking_schedule_controller.dart';
import 'package:shefaa/features/booking/presentation/controller/patient_form_controller.dart';
import 'package:shefaa/features/booking/presentation/controller/support_us_controller.dart';

class BookingValidator {
  final BookingScheduleController schedule;
  final PatientFormController patient;
  final SupportUsController supportUs;

  BookingValidator({
    required this.schedule,
    required this.patient,
    required this.supportUs,
  }) {
    schedule.addListener(_validate);
    patient.addListener(_validate);
    supportUs.addListener(_validate);
    _validate();
  }

  final ValueNotifier<String?> validationMessage = ValueNotifier(null);

  int _step = 0;

  void setStep(int step) {
    _step = step;
    _validate();
  }

  void _validate() {
    validationMessage.value = switch (_step) {
      0 => _validateStep0(),
      1 => _validateStep1(),
      2 => _validateStep2(),
      _ => null,
    };
  }

  String? _validateStep0() {
    if (schedule.selectedDate == null) {
      return "التاريخ والميعاد مطلوب لاتمام الحجز";
    }
    if (schedule.selectedTime == null) return "من فضلك اختر ميعاد";

    return null;
  }

  String? _validateStep1() {
    final phoneError = AppValidation.validateNumber(
      patient.completeUsedPhone?.phone,
      patient.completeUsedPhone?.country.example.length,
    );
    if (phoneError != null) return "يرجى ادخال الهاتف بشكل صحيح";
    return null;
  }

  String? _validateStep2() {
    if (!supportUs.isCustomSelected) return null;
    final value = supportUs.amount;
    if (value == null) {
      return "برجعى ادخال المبلغ";
    }
    if (value < supportUs.min || value > supportUs.max) {
      return "يجب أن يكون المبلغ بين ${supportUs.min} و ${supportUs.max}";
    }
    return null;
  }

  void dispose() {
    schedule.removeListener(_validate);
    patient.removeListener(_validate);
    supportUs.removeListener(_validate);
    validationMessage.dispose();
  }
}
