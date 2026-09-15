import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/features/medical/shared/data/models/patient_model.dart';

class BookingRequest {
  final int doctorId;
  final int? clinicId;
  final DateTime bookingDate;
  final Patient? customPatient;

  const BookingRequest({
    required this.doctorId,
    this.clinicId,
    required this.bookingDate,
    this.customPatient,
  });

  Map<String, dynamic> toJson() => {
    'p_doctor_id': doctorId,
    'p_clinic_id': clinicId,
    'p_datetime': bookingDate.toIso8601String(),
    'p_custom_patient': customPatient?.toJson(),
  };
  BookingRequest copyWith({
    int? doctorId,
    int? clinicId,
    DateTime? bookingDate,
    Patient? customPatient,
    num? amount,
    PaymentMethod? paymentMethod,
    num? supportUsAmount,
  }) {
    return BookingRequest(
      doctorId: doctorId ?? this.doctorId,
      clinicId: clinicId ?? this.clinicId,
      bookingDate: bookingDate ?? this.bookingDate,
      customPatient: customPatient ?? this.customPatient,
    );
  }
}
