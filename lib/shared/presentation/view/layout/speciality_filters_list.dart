import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_filter_chips.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/shared/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/category_svg.dart';

class SpecialityFiltersList extends StatelessWidget {
  const SpecialityFiltersList({
    super.key,
    this.initialIndex = -1,
    this.specialities = const [],
    this.onChanged,
  });

  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final List<SpecialityEntity> specialities;

  @override
  Widget build(BuildContext context) {
    return AppFiltersChips(
      initialIndex: initialIndex + 1,
      itemCount: specialities.length + 1,
      onChanged: (index) => onChanged?.call(index - 1),
      itemBuilder: (context, index, isSelected) {
        if (index == 0) {
          return AppIconText(
            text: "الكل",
            color: isSelected
                ? AppColors.white
                : context.colors.surfaceContainerHighest,
            textStyle: context.textTheme.labelLarge,
          );
        }

        final speciality = specialities[index - 1];

        return AppIconText(
          customIcon: CategorySVG(
            url: speciality.icon,
            color: isSelected
                ? AppColors.white
                : context.colors.surfaceContainerHighest,
            size: UISizes.sp20,
          ),
          text: speciality.title,
          color: isSelected
              ? AppColors.white
              : context.colors.surfaceContainerHighest,
          textStyle: context.textTheme.labelLarge,
        );
      },
    );
  }
}
