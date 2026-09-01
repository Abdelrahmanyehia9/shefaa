import 'package:shefaa/core/enum/speciality_tags.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/shared/domain/entity/speciality_entity.dart';

class Speciality {
  final int id;
  final String name;
  final String icon;
  final int doctorsCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<SpecialityTags>? tags;

  Speciality({
    required this.id,
    required this.name,
    required this.icon,
    required this.doctorsCount,
    required this.createdAt,
    this.updatedAt,
    this.tags,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
    id: json['id'],
    name: json['name'],
    icon: json['icon'],
    doctorsCount: json['doctors_count'],
    tags: (json['tags'] as List<dynamic>?)
        ?.map(
          (e) =>
              enumFromJson<SpecialityTags>(e as String, SpecialityTags.values),
        )
        .whereType<SpecialityTags>()
        .toList(),
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at']),
  );
}

extension SpecialityModelExt on Speciality {
  SpecialityEntity toEntity() => SpecialityEntity(
    id: id,
    title: name,
    tags: tags ?? [],
    icon: icon,
    numOfSpecialist: doctorsCount,
  );
}
