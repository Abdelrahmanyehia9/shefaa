import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/speciality_tags.dart';
import 'package:shefaa/core/utils/fake_data.dart';

class SpecialityEntity extends Equatable {
  final String id;
  final String title;
  final String icon;
  final int numOfSpecialist;
  final DateTime ?createdAt;
  final List<SpecialityTags>tags;

  const SpecialityEntity(
      {required this.id,required this.tags ,this.createdAt, required this.title, required this.icon, required this.numOfSpecialist});

  @override
  List<Object?> get props => [id];

  static SpecialityEntity mock = SpecialityEntity(
      id: FakeData.string(),
      title: FakeData.string(),
      icon: FakeData.string(),
      tags: SpecialityTags.values,
      numOfSpecialist: FakeData.integer);

}
