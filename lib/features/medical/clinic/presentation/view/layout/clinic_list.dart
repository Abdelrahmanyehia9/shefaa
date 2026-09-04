import 'package:flutter/material.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/presentation/view/widgets/clinic_card.dart';

class ClinicList extends StatelessWidget {
  final bool shrinkWrap;
  final Axis axis;
  final List<ClinicEntity> clinics;
  final bool heroEnabled  ;
  final ScrollController? controller;

  final Widget? footer;
  const ClinicList({
    super.key,
    this.axis = Axis.horizontal,
    this.shrinkWrap = false,
    this.clinics = const [],
    this.controller,
    this.heroEnabled = true ,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: axis.isVertical ? null : ClinicCard.cardSize.height,
      child: ListView.separated(
        controller: controller,
        clipBehavior: axis.isVertical ? Clip.hardEdge : Clip.none,
        padding: EdgeInsets.zero,
        shrinkWrap: shrinkWrap,
        scrollDirection: axis,
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
        itemBuilder: (_, i) {
          if (i == clinics.length) {
            return footer!;
          }
          return ClinicCard(clinic: clinics[i], heroEnabled: heroEnabled,);
        },
        separatorBuilder: (_, _) => Gap(axis: axis, UISizes.sp12),
        itemCount: clinics.length + (footer != null ? 1 : 0),
      ),
    );
  }
}
