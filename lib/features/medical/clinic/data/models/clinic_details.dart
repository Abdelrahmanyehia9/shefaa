import 'package:shefaa/features/medical/clinic/data/models/clinic.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_details_entity.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor.dart';
import 'package:shefaa/features/review/data/models/review.dart';
import 'package:shefaa/features/location/data/models/location.dart';
import 'package:shefaa/shared/data/models/media.dart';
import 'package:shefaa/shared/data/models/rate.dart';
import 'package:shefaa/features/medical/speciality/data/model/speciality.dart';
import 'package:shefaa/shared/data/models/working_hour.dart';

class ClinicDetails extends Clinic {
  final List<WorkingHour> workingHour;
  final String? bio;
  final List<Speciality> specialities;
  final List<Media> media;
  final List<Review> reviews;
  final List<Doctor>doctors;

  const ClinicDetails({
    required super.id,
    required super.name,
    required super.location,
    required this.workingHour,
    this.bio,
    required this.specialities,
    required this.media,
    required this.reviews,
    required super.rate,
    required this.doctors,
    super.imageCover,
    super.logo,
  });

  factory ClinicDetails.fromJson(Map<String, dynamic> json) {
    return ClinicDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      doctors: (json['doctors'] as List?)
          ?.map((e) => Doctor.fromJson(e))
          .toList() ??
          [],
      rate: Rate.fromJson(json['rate'] as Map<String, dynamic>),
      imageCover: json['cover'] as String?,
      logo: json['logo'] as String?,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      bio: json['bio'],
      specialities:
      (json['specialities'] as List?)
          ?.map((e) => Speciality.fromJson(e))
          .toList() ??
          [],

      workingHour:
      (json['working_hour'] as List?)
          ?.map((e) => WorkingHour.fromJson(e))
          .toList() ??
          [],
      reviews:
      (json['reviews'] as List?)?.map((e) => Review.fromJson(e)).toList() ??
          [],
      media:
      (json['media'] as List?)?.map((e) => Media.fromJson(e)).toList() ??
          [],
    );
  }

  @override
  ClinicDetails copyWith({
    int? id,
    String? name,
    String? logo,
    Location? location,
    String? imageCover,
    Rate? rate,
  }) =>
      ClinicDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        logo: logo ?? this.logo,
        location: location ?? this.location,
        imageCover: imageCover ?? this.imageCover,
        rate: rate ?? this.rate,
        workingHour: workingHour,
        specialities: specialities,
        media: media,
        doctors: doctors,
        reviews: reviews,
      );


  @override
  ClinicDetailsEntity toEntity() =>
      ClinicDetailsEntity(
          id: id,
          name: name,
          rate: rate.toEntity(),
          coverImage: imageCover,
          bio: bio,
          logo: logo,
          location: location.toEntity(),
          workingHour: workingHour.map((e)=>e.toEntity()).toList(),
          specialities: specialities.map((e)=>e.toEntity()).toList(),
          media: media.map((e)=>e.toEntity()).toList(),
          reviews: reviews.map((e)=>e.toEntity()).toList(),
          doctors: doctors.map((e)=>e.toEntity()).toList());
}
