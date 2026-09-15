import 'package:flutter/material.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/features/medical/speciality/presentation/controller/get_specialities_cubit.dart';
import 'package:shefaa/features/medical/speciality/presentation/view/layout/speciality_filters_list.dart';

class MedicalSpecialityFilters extends StatelessWidget {
  final MedicalRequest filter;
  final ValueChanged<int?> onChanged;
  final List<SpecialityEntity> Function(List<SpecialityEntity> all)?
  filteredSpecialities;

  const MedicalSpecialityFilters({
    super.key,
    required this.onChanged,
    required this.filter,
    this.filteredSpecialities,
  });

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<GetSpecialitiesCubit, List<SpecialityEntity>>(
      successBuilder: (s) {
        final selectedId = filter.specialityId;
        final remaining = s.where((e) => e.id != selectedId).toList();

        final specialities = [
          if (selectedId != null) ...s.where((e) => e.id == selectedId),
          ...(filteredSpecialities?.call(remaining) ?? remaining),
        ];

        if (specialities.isNullOrEmpty) {
          return const SizedBox.shrink();
        }

        return SpecialityFiltersList(
          specialities: specialities,
          initialIndex: selectedId == null
              ? -1
              : specialities.indexWhere((e) => e.id == selectedId),
          onChanged: (i) => onChanged(i == -1 ? null : specialities[i].id),
        );
      },
    );
  }
}
