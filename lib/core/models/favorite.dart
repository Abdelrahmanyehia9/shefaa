import 'package:flutter/material.dart';
import 'package:shefaa/core/enum/favorite_type.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/clinic_card.dart';
import 'package:shefaa/shared/presentation/view/widgets/doctor_card.dart';

abstract interface class Favorite {
  FavoriteType get type;
  int get id;
}

extension FavExt on Favorite {
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
