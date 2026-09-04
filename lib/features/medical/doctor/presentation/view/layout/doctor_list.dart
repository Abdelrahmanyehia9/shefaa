import 'package:flutter/material.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/widgets/doctor_card.dart';

class DoctorList extends StatelessWidget {
  final bool shrinkWrap;
  final List<DoctorEntity> doctors;
  final Widget? footer;
  final ScrollController? controller;
  final bool heroEnabled ;

  const DoctorList({
    super.key,
    this.doctors = const [],
    this.shrinkWrap = false,
    this.heroEnabled = true,
    this.footer,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final hasFooter = footer != null;
    return ListView.separated(
      controller: controller,
      shrinkWrap: shrinkWrap,
      padding: EdgeInsets.zero,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemCount: doctors.length + (hasFooter ? 1 : 0),
      itemBuilder: (_, index) {
        if (index == doctors.length) {
          return footer!;
        }
        return DoctorCard(doctor: doctors[index], heroEnabled: heroEnabled,);
      },
      separatorBuilder: (_, _) => Gap(axis: Axis.vertical, UISizes.sp12),
    );
  }
}
