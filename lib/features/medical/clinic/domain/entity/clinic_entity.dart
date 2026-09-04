import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/medical_type.dart';
import 'package:shefaa/core/models/medical.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/features/location/domain/entity/location_entity.dart';
import 'package:shefaa/shared/domain/entity/rate_entity.dart';

class ClinicEntity extends Equatable implements Medical {
  @override
  final int id;
  final String name;
  final RateEntity rate;
  final String? logo;
  final String? coverImage;
  final LocationEntity location;

  const ClinicEntity({
    required this.id,
    required this.name,
    required this.rate,
    required this.coverImage,
    required this.logo,
    required this.location,
  });

  @override
  List<Object?> get props => [id];

  static ClinicEntity get mock => ClinicEntity(
    id: FakeData.integer,
    name: FakeData.string(),
    rate: RateEntity.mock,
    logo: FakeData.string(),
    coverImage: FakeData.string(),
    location: LocationEntity.mock,
  );

  @override
  MedicalType get type => MedicalType.clinic;
}
