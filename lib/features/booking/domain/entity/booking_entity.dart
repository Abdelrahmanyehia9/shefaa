import 'package:equatable/equatable.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/models/local_time.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/features/booking/domain/entity/booking_cancellation_entity.dart';
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
  final BookingCancellationEntity? cancellation;

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
    this.cancellation,
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
    cancellation: BookingCancellationEntity.mock,
    isRated: FakeData.boolean,
  );
  BookingEntity copyWith({
    int? id,
    String? patientId,
    DoctorEntity? doctor,
    ClinicEntity? clinic,
    DateTime? time,
    bool? notificationEnabled,
    bool? isRated,
    List<PaymentEntity>? payment,
    PatientEntity? customPatient,
    BookingStatus? status,
    BookingCancellationEntity? cancellation,
  }) {
    return BookingEntity(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctor: doctor ?? this.doctor,
      clinic: clinic ?? this.clinic,
      time: time ?? this.time,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      isRated: isRated ?? this.isRated,
      payment: payment ?? this.payment,
      customPatient: customPatient ?? this.customPatient,
      status: status ?? this.status,
      cancellation: cancellation ?? this.cancellation,
    );
  }

  String get patientName => (customPatient!=null ? customPatient!.user.firstname : sessionCubit.currentUser?.completeName) ?? "غير معروف" ;

  PaymentEntity get lastPayment => payment.last ;
  LocalTime get localTime => LocalTime(hour: time.hour, minute: time.minute) ;

}
