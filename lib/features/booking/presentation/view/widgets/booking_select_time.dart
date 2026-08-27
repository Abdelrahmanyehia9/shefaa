import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_filter_chips.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

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
      ],
    );
  }
}
