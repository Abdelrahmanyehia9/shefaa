import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_filter_chips.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class BookingSelectDate extends StatelessWidget {
  const BookingSelectDate({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColor = context.colors.onPrimary;
    final unSelectedColor = context.colors.surfaceContainerHighest;
    return Column(
      children: [
        const SectionHeader(title: "اختر التاريخ"),
        AppFiltersChips(
          itemCount: 7,
          height: UISizes.sp72,
          width: UISizes.sp72,
          radius: UISizes.sp16,
          itemBuilder: (_, i, isSelected) {
            final color = isSelected ? selectedColor : unSelectedColor;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  "اليوم",
                  style: context.textTheme.labelSmall,
                  height: 0,
                  color: color.withAppOpacity(0.7),
                ),
                AppText(
                  "4 فبراير",
                  style: context.textTheme.labelMedium,
                  color: color,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
