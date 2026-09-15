import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/features/booking/domain/entity/payment_entity.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/shared/domain/entity/patient_entity.dart';

class BookingEntity extends Equatable {
  final int id;
  final String patientId;
  final DoctorEntity doctor;
  final ClinicEntity? clinic;
  final DateTime time;
  final bool notificationEnabled, isRated;
  final List<PaymentEntity> payment;
  final PatientEntity? customPatient;
  final BookingStatus status;
  final String? cancellationReason;

  const BookingEntity({
    required this.id,
    required this.patientId,
    required this.doctor,
    this.clinic,
    required this.time,
    this.notificationEnabled = true,
    required this.payment,
    this.customPatient,
    required this.status,
    this.isRated = false,
    this.cancellationReason,
  });

  @override
  List<Object?> get props => [id, patientId, doctor, clinic];

  static BookingEntity get mock => BookingEntity(
    id: FakeData.integer,
    patientId: FakeData.string(),
    doctor: DoctorEntity.mock,
    clinic: ClinicEntity.mock,
    time: FakeData.dateTime,
    payment: PaymentEntity.mock.fakeList(2),
    status: BookingStatus.upcoming,
    customPatient: PatientEntity.mock,
    cancellationReason: FakeData.string(15),
    isRated: FakeData.boolean,
  );
}
