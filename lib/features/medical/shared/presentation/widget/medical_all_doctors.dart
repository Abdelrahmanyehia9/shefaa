import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_all_doctors_cubit.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/layout/doctor_list.dart';
import 'package:shefaa/features/medical/shared/presentation/layout/medical_list.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_speciality_filters.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/app_search_bar.dart';

class MedicalAllDoctors extends StatefulWidget {
  final DoctorRequest? initialRequest;

  const MedicalAllDoctors({super.key, required this.initialRequest});

  @override
  State<MedicalAllDoctors> createState() => _MedicalAllDoctorsState();
}

class _MedicalAllDoctorsState extends State<MedicalAllDoctors> {
  late DoctorRequest _request;

  @override
  void initState() {
    _request = widget.initialRequest ?? const DoctorRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h6,
      children: [
        AppSearchBar(
          hint: "البحث باسم الدكتور ...",
          onChange: (q) => _onQueryChange(context, q),
        ),
        MedicalSpecialityFilters(
          filteredSpecialities: (s) => s.sortedByDoctors,
          onChanged: (id) => _onSpecialityChange(context, id),
          filter: _request,
        ),
        Gap.small(),
        Expanded(
          child: MedicalList<GetAllDoctorsCubit, DoctorEntity>(
            mockItems: () => DoctorEntity.mock.fakeList(12),
            itemListBuilder:
                (items, {required controller, footer, required heroEnabled}) =>
                    DoctorList(
                      controller: controller,
                      doctors: items,
                      footer: footer,
                      heroEnabled: heroEnabled,
                    ),
          ),
        ),
      ],
    );
  }

  Future<void> _onQueryChange(BuildContext context, String? query) async {
    _request = _request.copyWith(query: query);
    context.read<GetAllDoctorsCubit>().fetchFiltered(request: _request);
  }

  Future<void> _onSpecialityChange(BuildContext context, int? specId) async {
    _request = _request.copyWith(specialityId: specId);
    context.read<GetAllDoctorsCubit>().fetchFiltered(request: _request);
  }
}
