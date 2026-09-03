import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/speciality_tags.dart';
import 'package:shefaa/core/utils/fake_data.dart';

class SpecialityEntity extends Equatable {
  final int id;
  final String title;
  final String icon;
  final int numOfDoctor;
  final int numOfClinics;
  final DateTime? createdAt;
  final List<SpecialityTags> tags;

  const SpecialityEntity({
    required this.id,
    required this.tags,
    this.createdAt,
    required this.title,
    required this.icon,
    required this.numOfDoctor,
    required this.numOfClinics
  });

  @override
  List<Object?> get props => [id];

  static SpecialityEntity mock = SpecialityEntity(
    id: FakeData.integer,
    title: FakeData.string(),
    icon: FakeData.string(),
    tags: SpecialityTags.values,
    numOfDoctor: FakeData.integer,
    numOfClinics: FakeData.integer
  );
}


extension SpecialityEXT on List<SpecialityEntity>{
  List<SpecialityEntity> get sortedByClinics{
    return where((e)=>e.numOfClinics>0).sortedBy((e)=>e.numOfClinics).reversed.toList();
  }
  List<SpecialityEntity> get sortedByDoctors{
    return where((e)=>e.numOfDoctor>0).sortedBy((e)=>e.numOfDoctor).reversed.toList();
  }




}