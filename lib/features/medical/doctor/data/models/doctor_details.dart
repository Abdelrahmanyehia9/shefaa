import 'package:shefaa/core/enum/docotor_level.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/features/booking/data/model/booking_options.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_details_entity.dart';
import 'package:shefaa/features/review/data/models/review.dart';
import 'package:shefaa/shared/data/models/rate.dart';
import 'package:shefaa/features/medical/speciality/data/model/speciality.dart';
import 'package:shefaa/shared/data/models/working_hour.dart';

class DoctorDetails extends Doctor {
  final String? bio;
  final Clinic clinic;
  final List<WorkingHour> workingHour;
  final List<Review> reviews;
  final BookingOptions bookingOptions;

  const DoctorDetails({
    required super.id,
    required super.name,
    required super.image,
    required super.rate,
    required super.speciality,
    required super.level,
    this.bio,
    required this.clinic,
    required this.workingHour,
    required this.reviews,
    required this.bookingOptions,
  });

  factory DoctorDetails.fromJson(Map<String, dynamic> json) {
    return DoctorDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      speciality: Speciality.fromJson(json['speciality']),
      image: json['image'] as String?,
      rate: Rate.fromJson(json['rate']),
      level:
          enumFromJson<DoctorLevel>(json['doctor_level'], DoctorLevel.values) ??
          DoctorLevel.specialist,
      bio: json['bio'],
      clinic: Clinic.fromJson(json['clinic']),
      bookingOptions: BookingOptions.fromJson(json),
      workingHour:
          (json['working_hour'] as List?)
              ?.map((e) => WorkingHour.fromJson(e))
              .toList() ??
          [],
      reviews:
          (json['reviews'] as List?)?.map((e) => Review.fromJson(e)).toList() ??
          [],
    );
  }

  @override
  DoctorDetailsEntity toEntity() => DoctorDetailsEntity(
    id: id,
    name: name,
    speciality: speciality.toEntity(),
    image: image,
    rate: rate.toEntity(),
    clinic: clinic.toEntity(),
    bio: bio,
    bookingOptions: bookingOptions.toEntity(),
    workingHour: workingHour.map((e) => e.toEntity()).toList(),
    reviews: reviews.map((e) => e.toEntity()).toList(),
    level: level,
  );
}
