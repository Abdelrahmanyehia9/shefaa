import 'package:flutter/material.dart';
import 'package:shefaa/core/enum/medical_type.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/clinic/presentation/view/widgets/clinic_card.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/widgets/doctor_card.dart';

abstract interface class Medical {
  MedicalType get type;
  int get id;
}

extension FavExt on Medical {
  Widget card() {
    if (this is DoctorEntity) {
      return DoctorCard(doctor: this as DoctorEntity);
    }
    if (this is ClinicEntity) {
      return ClinicCard(clinic: this as ClinicEntity);
    }
    return const SizedBox();
  }
}
