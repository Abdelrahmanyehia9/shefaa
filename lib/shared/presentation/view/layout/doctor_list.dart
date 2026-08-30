import 'package:flutter/material.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/doctor_card.dart';

class DoctorList extends StatelessWidget {
  final bool shrinkWrap;
  final List<DoctorEntity> doctors;

  const DoctorList({
    super.key,
    this.doctors = const [],
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      padding: EdgeInsets.zero,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemBuilder: (_, i) => DoctorCard(doctor: doctors[i]),
      separatorBuilder: (_, _) => Gap(axis: Axis.vertical, UISizes.sp12),
      itemCount: doctors.length,
    );
  }
}
