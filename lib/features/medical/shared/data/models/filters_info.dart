import 'package:flutter/material.dart';
import 'package:shefaa/core/enum/docotor_level.dart';
import 'package:shefaa/core/enum/sort_by.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';

class FiltersInfo {
  final List<SpecialityEntity>? specialities;
  final List<int>? ratingsStars;
  final RangeValues? priceBounds;
  final RangeValues distanceBounds;
  final List<DoctorLevel>? doctorLevels;
  final List<SortBy> sorts;

  FiltersInfo({
    required this.specialities,
    this.ratingsStars = const [1, 2, 3, 4],
    this.priceBounds = const RangeValues(0, 10000),
     this.distanceBounds = const RangeValues(0.1, 20),
    this.doctorLevels = DoctorLevel.values,
     this.sorts = SortBy.values,
  });

  factory FiltersInfo.doctor(List<SpecialityEntity>? specialities) =>
      FiltersInfo(
        specialities: specialities,
      );

  factory FiltersInfo.clinic(List<SpecialityEntity>? specialities) =>
      FiltersInfo(
        specialities: specialities,
        doctorLevels: null,
        priceBounds: null,
      );
}
