import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/shared/data/models/filters.dart';

class MedicalFiltersChips extends StatelessWidget {
  final ValueNotifier<Filters?> filters;

  const MedicalFiltersChips({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: filters,
      builder: (_, v, _) {
        if (v == null) return const SizedBox.shrink();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            spacing: UISizes.w8,
            children: v.chips
                .map(
                  (e) => _chip(e: e, context: context)
            )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _chip({ required({ String title, String value}) e , required BuildContext context})=>AppChip(
    paddingHr: UISizes.w24,
    paddingVr: UISizes.h2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          e.title,
          style: context.textTheme.labelSmall,
          color: context.colors.onPrimary.softLight,
          fontSize: UISizes.sp12,
        ),
        AppText(
          e.value,
          height: 0,
          color: context.colors.onPrimary,
          style: context.textTheme.titleMedium,
        ),
      ],
    ),
  );
}
