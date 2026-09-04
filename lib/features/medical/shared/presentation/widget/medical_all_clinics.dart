import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/presentation/controllers/get_all_clinics_cubit.dart';
import 'package:shefaa/features/medical/clinic/presentation/view/layout/clinic_list.dart';
import 'package:shefaa/features/medical/shared/presentation/layout/medical_layout.dart';

class MedicalAllClinics extends StatelessWidget {
  const MedicalAllClinics({super.key});

  @override
  Widget build(BuildContext context) {
    return MedicalLayout<GetAllClinicsCubit, ClinicEntity>(
      mockItems: () => ClinicEntity.mock.fakeList(12),
      itemListBuilder: (items, { required controller, footer, required heroEnabled}) =>
          ClinicList(
            axis: Axis.vertical,
            heroEnabled: heroEnabled,
            footer: footer,
            clinics: items,
            controller: controller,
          ),
    );
  }
}
