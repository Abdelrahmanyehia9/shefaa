import 'package:equatable/equatable.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/shared/domain/entity/location_entity.dart';
import 'package:shefaa/shared/domain/entity/rate_entity.dart';

class DoctorEntity extends Equatable {
  final String id;
  final String name;
  final String speciality;
  final String? image;
  final RateEntity rate;
  final LocationEntity location;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.speciality,
    this.image,
    required this.rate,
    required this.location
  });

  @override
  List<Object?> get props => [id];

  static DoctorEntity get mock =>
      DoctorEntity(
          id: FakeData.string(),
          name: FakeData.string(3),
          speciality: FakeData.string(2),
          rate: RateEntity.mock,
          location: LocationEntity.mock) ;
}
