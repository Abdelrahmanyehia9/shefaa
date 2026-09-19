import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/features/booking/data/model/booking_cancellation.dart';
import 'package:shefaa/features/medical/shared/data/models/patient_model.dart';
import 'package:shefaa/features/booking/data/model/payment.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor.dart';

class Booking {
  final int id;
  final String patientId;
  final Doctor doctor;
  final Clinic? clinic;
  final DateTime time, createdAt;
  final bool notificationEnabled, isRated;
  final List<Payment>? payments;
  final Patient? customPatient;
  final BookingStatus status;
  final BookingCancellation? cancellation;

  const Booking({
    required this.id,
    required this.patientId,
    required this.doctor,
    required this.clinic,
    required this.time,
    required this.notificationEnabled,
    required this.payments,
    required this.customPatient,
    required this.status,
    required this.createdAt,
    required this.isRated,
    required this.cancellation,
  });

  BookingEntity toEntity() => BookingEntity(
    id: id,
    patientId: patientId,
    doctor: doctor.toEntity(),
    clinic: clinic?.toEntity(),
    time: time,
    notificationEnabled: notificationEnabled,
    payment: payments?.map((e) => e.toEntity()).toList() ?? [],
    customPatient: customPatient?.toEntity(),
    isRated: isRated,
    cancellation:cancellation?.toEntity() ,
    status: status,
  );

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json['id'],
    createdAt: DateTime.parse(json['created_at']),
    patientId: json['patient_id'],
    doctor: Doctor.fromJson(json['doctor']),
    clinic: json['clinic'] == null ? null : Clinic.fromJson(json['clinic']),
    time: DateTime.parse(json['time']),
    notificationEnabled: json['notify'],

    payments: json['payments'] == null
        ? []
        : (json['payments'] as List).map((p) => Payment.fromJson(p)).toList(),
    customPatient: json['custom_patient'] == null
        ? null
        : Patient.fromJson(json['custom_patient']),
    status:
        enumFromJson(json["status"], BookingStatus.values) ??
        BookingStatus.upcoming,
    isRated: json['is_rated'],
    cancellation:json['cancellation_reason']==null ? null :  BookingCancellation.fromJson( json['cancellation_reason']),
  );



}
