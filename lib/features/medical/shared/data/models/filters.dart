import 'package:flutter/material.dart';
import 'package:shefaa/core/enum/docotor_level.dart';
import 'package:shefaa/core/enum/filter_type.dart';
import 'package:shefaa/core/enum/sort_by.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';

class Filters {
  final List<SpecialityEntity>? specialities;
  final int? rating;
  final RangeValues? price;
  final double? distance;
  final List<DoctorLevel>? levels;
  final SortBy? sortBy;

  const Filters({
    required this.specialities,
    required this.rating,
    required this.price,
    required this.distance,
    required this.levels,
    required this.sortBy,
  });

  Filters copyWith({
    List<SpecialityEntity>? specialities,
    int? Function()? rating,
    RangeValues? price,
    double? distance,
    List<DoctorLevel>? levels,
    SortBy? sortBy,
  }) => Filters(
    specialities: specialities ?? this.specialities,
    rating: rating != null ? rating() : this.rating,
    price: price ?? this.price,
    distance: distance ?? this.distance,
    levels: levels ?? this.levels,
    sortBy: sortBy ?? this.sortBy,
  );
}

extension FiltersStrEXT on Filters {
  List<({String title, String value})> get chips => [
    if (!specialities.isNullOrEmpty)
      (
      title: FilterType.speciality.title,
      value: specialities!.filterLabel(count: 1)
      ),

    if (rating != null)
      (

      title: FilterType.rating.title,
      value: "$rating أو أكثر",
      ),

    if (price != null)
      (
      title: FilterType.price.title,
      value: "${price!.start.toInt()} - ${price!.end.toInt()} جنيه",
      ),
if(distance !=null)
    (
    title: FilterType.distance.title,
    value: distance! < 1
        ? "${(distance! * 1000).toInt()} متر"
        : "${distance!.toStringAsFixed(1)} كيلومتر",
    ),

    if (!levels.isNullOrEmpty)
      (
      title: FilterType.doctorLevel.title,
      value: levels!.map((e) => e.text).join(" , "),
      ),
if(sortBy!=null)
    (
    title: FilterType.sortBy.title,
    value: sortBy!.text,
    ),
  ];
}