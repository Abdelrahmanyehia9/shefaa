import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/features/medical/speciality/presentation/view/widget/specialty_category_card.dart';

class SpecialityCategoriesList extends StatelessWidget {
  final Axis axis;
  final bool shrinkWrap;
  final List<SpecialityEntity> specialities;

  const SpecialityCategoriesList({
    super.key,
    this.shrinkWrap = false,
    this.axis = Axis.horizontal,
    this.specialities = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (axis.isVertical) {
      return ListView.separated(
        itemCount: specialities.length,
        padding: EdgeInsets.zero,
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
        separatorBuilder: (_, _) => const Divider(),
        itemBuilder: (_, i) => SpecialtyCategoryCard(
          axis: Axis.horizontal,
          height: UISizes.sp28,
          width: UISizes.sp32,
          speciality: specialities[i],
        ),
      );
    }
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: UISizes.w4,
        children: List.generate(
          specialities.length,
          (i) => SpecialtyCategoryCard(speciality: specialities[i]),
        ),
      ),
    );
  }
}
