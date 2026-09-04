import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/review/domain/entity/review_entity.dart';
import 'package:shefaa/features/location/domain/entity/location_entity.dart';
import 'package:shefaa/shared/domain/entity/media_entity.dart';
import 'package:shefaa/shared/domain/entity/rate_entity.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/domain/entity/working_hour_entity.dart';

class ClinicDetailsEntity extends ClinicEntity {
  final List<WorkingHourEntity> workingHour;
  final String? bio;
  final List<SpecialityEntity> specialities;
  final List<MediaEntity> media;
  final List<ReviewEntity> reviews;
  final List<DoctorEntity> doctors;

  const ClinicDetailsEntity({
    required super.id,
    required super.name,
    required super.rate,
    required super.coverImage,
    required super.logo,
    required super.location,
    required this.workingHour,
    this.bio,
    required this.specialities,
    required this.media,
    required this.reviews,
    required this.doctors,
  });


  static ClinicDetailsEntity get mock =>
      ClinicDetailsEntity(
          id: FakeData.integer,
          name: FakeData.string(3),
          rate: RateEntity.mock,
          coverImage: FakeData.string(3),
          logo: FakeData.string(),
          location: LocationEntity.mock,
          workingHour: WorkingHourEntity.mock.fakeList(2),
          specialities: SpecialityEntity.mock.fakeList(3),
          media: MediaEntity.mock.fakeList(9),
          reviews: ReviewEntity.mock.fakeList(9),
          doctors: DoctorEntity.mock.fakeList(6));
}
