import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/enum/medical_type.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_all_clinics.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_all_doctors.dart';

final class MedicalScreenArgs {
  final MedicalType type;
  final MedicalRequest? initialRequest;

  const MedicalScreenArgs({required this.type, this.initialRequest});
}

class MedicalScreen extends StatelessWidget {
  final MedicalType type;
  final MedicalRequest? initialRequest;

  const MedicalScreen({
    super.key,
    this.type = MedicalType.doctor,
    required this.initialRequest,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppText(type.text)),
      body: _body(type),
    );
  }

  Widget _body(MedicalType type) => switch (type) {
    MedicalType.doctor => MedicalAllDoctors(
      initialRequest: initialRequest as DoctorRequest?,
    ),
    _ => MedicalAllClinics(initialRequest: initialRequest as ClinicRequest?),
  };
}
