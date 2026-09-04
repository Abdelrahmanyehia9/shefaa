import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/features/medical/speciality/presentation/view/widget/specialty_category_card.dart';

class SpecialityCategoriesGrid extends StatelessWidget {
  final List<SpecialityEntity> specialities;
  const SpecialityCategoriesGrid({super.key, this.specialities = const []});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: .65.sp,
      ),
      itemBuilder: (_, i) => SpecialtyCategoryCard(speciality: specialities[i]),
    );
  }
}
