import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/widgets/specialty_category_card.dart';

class SpecialityCategoriesList extends StatelessWidget {
  final Axis axis;
  final bool shrinkWrap;
  const SpecialityCategoriesList({
    super.key,
    this.shrinkWrap = false,
    this.axis = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    if (axis.isVertical) {
      return ListView.separated(
        itemCount: 15,
        padding: EdgeInsets.zero,
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
        separatorBuilder: (_, _) => const Divider(),
        itemBuilder: (_, i) =>
            const SpecialtyCategoryCard(axis: Axis.horizontal),
      );
    }
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: UISizes.w4,
        children: List.generate(12, (_) => const SpecialtyCategoryCard()),
      ),
    );
  }
}
