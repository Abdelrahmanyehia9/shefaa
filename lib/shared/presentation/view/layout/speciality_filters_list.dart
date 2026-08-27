import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_filter_chips.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/shared/presentation/view/widgets/category_svg.dart';

class SpecialityFiltersList extends StatelessWidget {
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  const SpecialityFiltersList({
    super.key,
    required this.initialIndex,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppFiltersChips(
      itemCount: 12,
      itemBuilder: (context, i, isSelected) => AppIconText(
        customIcon: CategorySVG(
          color: isSelected
              ? AppColors.white
              : context.colors.surfaceContainerHighest,
          size: UISizes.sp20,
        ),
        text: "تجميل",
        color: isSelected
            ? AppColors.white
            : context.colors.surfaceContainerHighest,
        textStyle: context.textTheme.labelLarge,
      ),
    );
  }
}
