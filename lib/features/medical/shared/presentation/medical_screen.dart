import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/enum/medical_type.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/medical/clinic/presentation/controllers/get_all_clinics_cubit.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_all_doctors_cubit.dart';
import 'package:shefaa/features/medical/shared/data/models/filters.dart';
import 'package:shefaa/features/medical/shared/data/models/filters_info.dart';
import 'package:shefaa/features/medical/shared/presentation/filters_screen.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_all_clinics.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_all_doctors.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_filter_chips.dart';
import 'package:shefaa/features/medical/speciality/presentation/controller/get_specialities_cubit.dart';
import 'package:shefaa/shared/presentation/view/widgets/app_search_bar.dart';

final class MedicalScreenArgs {
  final MedicalType type;

  final GetSpecialitiesCubit specialitiesCubit;

  const MedicalScreenArgs({
    required this.specialitiesCubit,
    required this.type,
  });
}

class MedicalScreen extends StatefulWidget {
  final MedicalType type;

  const MedicalScreen({super.key, this.type = MedicalType.doctor});

  @override
  State<MedicalScreen> createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  final ValueNotifier<Filters?> _filtersNotifier = ValueNotifier(null);
  String? _query;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppText(widget.type.text)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: UISizes.h12,
        children: [
          AppSearchBar(
            hint: "البحث فى ${widget.type.text} .....",
            onChange: (s) => _query = s,
            onFilterTap: () async {
              final specialities = context
                  .read<GetSpecialitiesCubit>()
                  .state
                  .data;
              final info = widget.type.isDoctor
                  ? FiltersInfo.doctor(specialities)
                  : FiltersInfo.clinic(specialities);
              final filters = await context.pushNamed(
                Routes.filters,
                arguments: FilterScreenArgs(
                  allFilters: info,
                  initialFilters: _filtersNotifier.value,
                ),
              );
              _filtersNotifier.value = filters as Filters?;
            },
          ),
          MedicalFiltersChips(filters: _filtersNotifier),
          Expanded(child: _body(widget.type)),
        ],
      ),
    );
  }

  Widget _body(MedicalType type) => switch (type) {
    MedicalType.doctor => BlocProvider(
      create: (context) => sl<GetAllDoctorsCubit>()..getAll(),
      child: const MedicalAllDoctors(),
    ),
    _ => BlocProvider(
      create: (context) => sl<GetAllClinicsCubit>()..getAll(),
      child: const MedicalAllClinics(),
    ),
  };
}

