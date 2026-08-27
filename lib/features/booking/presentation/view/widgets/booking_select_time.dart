import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_filter_chips.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class BookingSelectTime extends StatelessWidget {
  const BookingSelectTime({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColor = context.colors.onPrimary;
    final unSelectedColor = context.colors.surfaceContainerHighest;
    return Column(
      children: [
        const SectionHeader(title: "اختر الساعة"),
        AppFiltersChips(
          itemCount: 7,
          width: UISizes.sp110,
          radius: UISizes.sp32,
          itemBuilder: (_, i, isSelected) {
            final color = isSelected ? selectedColor : unSelectedColor;
            return AppText(
              "7:40 PM",
              style: context.textTheme.labelMedium,
              color: color,
            );
          },
        ),
        Gap.medium(),
        AppChip(
          color: AppColors.warning,
          monochromatic: true,
          child: AppIconText(
            text:  "التأخر عن الموعد قد يؤدي إلى فقدان دورك وتحديد موعد آخر حسب المتاح",
            textStyle: context.textTheme.titleSmall,
             color: AppColors.warning,
            icon: AppIcons.warning,
            expandedText: true,
          ),
        )
      ],
    );
  }
}
