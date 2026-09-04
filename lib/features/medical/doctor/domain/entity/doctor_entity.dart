import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/docotor_level.dart';
import 'package:shefaa/core/enum/medical_type.dart';
import 'package:shefaa/core/models/medical.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/shared/domain/entity/rate_entity.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';

class DoctorEntity extends Equatable implements Medical {
  @override
  final int id;
  final String name;
  final SpecialityEntity speciality;
  final DoctorLevel level;
  final String? image;
  final RateEntity rate;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.speciality,
    required this.level,
    this.image,
    required this.rate,
  });

  @override
  List<Object?> get props => [id, type];

  static DoctorEntity get mock => DoctorEntity(
    id: FakeData.integer,
    name: FakeData.string(3),
    speciality: SpecialityEntity.mock,
    level: DoctorLevel.specialist,
    rate: RateEntity.mock,
  );

  @override
  MedicalType get type => MedicalType.doctor;

  String get doctorTitle => "${level.text}  ${speciality.title}";
}
