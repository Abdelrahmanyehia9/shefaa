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
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_availability_entity.dart';

class BookingSelectTime extends StatelessWidget {
  final List<AvailabilitySlotEntity> slots;
  final int? initialIndex;
  final ValueChanged<int> onChanged;
  const BookingSelectTime({
    super.key,
    required this.onChanged,
    this.initialIndex,
    required this.slots,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = context.colors.onPrimary;
    final unSelectedColor = context.colors.surfaceContainerHighest;
    return Column(
      children: [
        const SectionHeader(title: "اختر الساعة"),
        AppFiltersChips(
          itemCount: slots.length,
          width: UISizes.sp110,
          radius: UISizes.sp32,
          initialIndex: initialIndex,
          isDisabled: (i) => slots[i].isBooked,
          onChanged: onChanged,
          itemBuilder: (_, i, isSelected, enabled) {
            final color = isSelected ? selectedColor : unSelectedColor;
            return AppText(
              slots[i].time.formatted,
              style: context.textTheme.labelMedium,
              color: !enabled ? color : context.colors.surfaceContainerLow,
            );
          },
        ),
        Gap.medium(),
        AppChip(
          color: AppColors.warning,
          monochromatic: true,
          child: AppIconText(
            text:
                "التأخر عن الموعد قد يؤدي إلى فقدان دورك وتحديد موعد آخر حسب المتاح",
            textStyle: context.textTheme.titleSmall,
            color: AppColors.warning,
            icon: AppIcons.warning,
            expandedText: true,
          ),
        ),
      ],
    );
  }
}
