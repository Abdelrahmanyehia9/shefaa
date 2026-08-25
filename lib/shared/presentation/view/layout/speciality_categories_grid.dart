import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shefaa/shared/presentation/view/widgets/specialty_category_card.dart';

class SpecialityCategoriesGrid extends StatelessWidget {
  const SpecialityCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: .65.sp,
      ),
      itemBuilder: (_, i) => const SpecialtyCategoryCard(),
    );
  }
}
