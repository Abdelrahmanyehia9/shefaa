import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_all_doctors_cubit.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/layout/doctor_list.dart';
import 'package:shefaa/features/medical/shared/presentation/layout/medical_layout.dart';

class MedicalAllDoctors extends StatelessWidget {
  const MedicalAllDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return MedicalLayout<GetAllDoctorsCubit, DoctorEntity>(
      mockItems: () => DoctorEntity.mock.fakeList(12),
      itemListBuilder: (items, {required controller, footer, required heroEnabled}) =>
          DoctorList(
            controller: controller,
            doctors: items,
            footer: footer,
            heroEnabled: heroEnabled,
          ),
    );
  }
}
