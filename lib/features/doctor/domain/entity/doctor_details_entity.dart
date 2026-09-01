import 'package:shefaa/core/enum/docotor_level.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/features/booking/domain/entity/booking_options_entity.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/review/domain/entity/review_entity.dart';
import 'package:shefaa/shared/domain/entity/rate_entity.dart';
import 'package:shefaa/shared/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/domain/entity/working_hour_entity.dart';

class DoctorDetailsEntity extends DoctorEntity {
  final String? bio;
  final ClinicEntity clinic;
  final List<WorkingHourEntity> workingHour;
  final List<ReviewEntity> reviews;
  final BookingOptionsEntity bookingOptions;

  const DoctorDetailsEntity({
    required super.id,
    required super.name,
    required super.speciality,
    required super.image,
    required super.rate,
    this.bio,
    required this.clinic,
    required this.workingHour,
    required this.bookingOptions,
    required this.reviews,
    required super.level,
  });

  static DoctorDetailsEntity get mock => DoctorDetailsEntity(
    id: FakeData.integer,
    name: FakeData.string(),
    speciality: SpecialityEntity.mock,
    image: FakeData.string(),
    rate: RateEntity.mock,
    bookingOptions: BookingOptionsEntity.mock,
    clinic: ClinicEntity.mock,
    workingHour: WorkingHourEntity.mock.fakeList(7),
    reviews: ReviewEntity.mock.fakeList(4),
    level: DoctorLevel.specialist,
  );
}
