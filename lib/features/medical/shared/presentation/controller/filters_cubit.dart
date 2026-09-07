import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/enum/docotor_level.dart';
import 'package:shefaa/core/enum/sort_by.dart';
import 'package:shefaa/features/medical/shared/data/models/filters.dart';
import 'package:shefaa/features/medical/shared/data/models/filters_info.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';

sealed class FiltersStates {
  const FiltersStates();
}


final class FiltersStatesLoaded extends FiltersStates {
  final FiltersInfo info;
  final Filters filters;

  const FiltersStatesLoaded({required this.info, required this.filters});
}

class FiltersCubit extends Cubit<FiltersStates> {
  FiltersCubit(FiltersInfo info, Filters? initialFilters )
      : super(
    FiltersStatesLoaded(
      info: info,
      filters:initialFilters ??  _defaultFilters(info),
    ),
  );

  FiltersInfo get info => (state as FiltersStatesLoaded).info;

  Filters get filters => (state as FiltersStatesLoaded).filters;

  void _emit(Filters newFilters) {
    emit(
      FiltersStatesLoaded(
        info: info,
        filters: newFilters,
      ),
    );
  }

  void updateSpecialities(List<SpecialityEntity> value) {
    _emit(filters.copyWith(specialities: value));
  }

  void updateRating(int? value) {
    _emit(filters.copyWith(rating: () => value));
  }

  void updatePrice(RangeValues value) {
    _emit(filters.copyWith(price: value));
  }

  void updateDistance(double value) {
    _emit(filters.copyWith(distance: value));
  }

  void updateLevels(List<DoctorLevel> value) {
    _emit(filters.copyWith(levels: value));
  }

  void updateSortBy(SortBy value) {
    _emit(filters.copyWith(sortBy: value));
  }

  void resetToDefaults() {
    _emit(_defaultFilters(info));
  }

  static Filters _defaultFilters(FiltersInfo info) {
    return Filters(
      specialities: const [],
      rating: null,
      price: null,
      distance: null,
      levels: info.doctorLevels?.isNotEmpty == true
          ? [info.doctorLevels!.first]
          : const [],
      sortBy: null,
    );
  }
}