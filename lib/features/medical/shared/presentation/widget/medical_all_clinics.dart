import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/presentation/controllers/get_all_clinics_cubit.dart';
import 'package:shefaa/features/medical/clinic/presentation/view/layout/clinic_list.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';
import 'package:shefaa/features/medical/shared/presentation/layout/medical_list.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_speciality_filters.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/app_search_bar.dart';

class MedicalAllClinics extends StatefulWidget {
  final ClinicRequest? initialRequest;

  const MedicalAllClinics({super.key, required this.initialRequest});

  @override
  State<MedicalAllClinics> createState() => _MedicalAllClinicsState();
}

class _MedicalAllClinicsState extends State<MedicalAllClinics> {
  late MedicalRequest _request;

  @override
  void initState() {
    _request = widget.initialRequest ?? const ClinicRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h6,
      children: [
        AppSearchBar(
          hint: "البحث باسم العيادة  ...",
          onChange: (query) => _onQueryChange(context, query),
        ),
        MedicalSpecialityFilters(
          filteredSpecialities: (s) => s.sortedByClinics,
          onChanged: (id) => _onSpecialityChange(context, id),
          filter: _request,
        ),
        Gap.small(),
        Expanded(
          child: MedicalList<GetAllClinicsCubit, ClinicEntity>(
            mockItems: () => ClinicEntity.mock.fakeList(12),
            itemListBuilder:
                (items, {required controller, footer,}) =>
                    ClinicList(
                      axis: Axis.vertical,
                      footer: footer,
                      clinics: items,
                      controller: controller,
                    ),
          ),
        ),
      ],
    );
  }

  Future<void> _onQueryChange(BuildContext context, String? query) async {
    _request = _request.copyWith(query: query);
    context.read<GetAllClinicsCubit>().fetchFiltered(request: _request);
  }

  Future<void> _onSpecialityChange(BuildContext context, int? specId) async {
    _request = _request.copyWith(specialityId: specId);
    context.read<GetAllClinicsCubit>().fetchFiltered(request: _request);
  }
}
