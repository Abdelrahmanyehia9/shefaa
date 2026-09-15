import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_filter_chips.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/enum/weekday.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_availability_entity.dart';

class BookingSelectDate extends StatelessWidget {
  final List<DoctorAvailabilityEntity> availability;
  final ValueChanged<int> onChanged;
  final int? initialIndex;
  const BookingSelectDate({
    super.key,
    required this.initialIndex,
    required this.onChanged,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    final List<(Weekday, DateTime)> days = availability.days;
    final selectedColor = context.colors.onPrimary;
    final unSelectedColor = context.colors.surfaceContainerHighest;
    return Column(
      children: [
        const SectionHeader(title: "اختر التاريخ"),
        AppFiltersChips(
          paddingVr: 4,
          paddingHr: 4,
          itemCount: days.length,
          height: UISizes.sp72,
          width: UISizes.sp84,
          radius: UISizes.sp16,
          onChanged: onChanged,
          initialIndex: initialIndex,
          isDisabled: (d) => availability[d].isFullBooked,
          itemBuilder: (_, i, isSelected, disabled) {
            final color = isSelected ? selectedColor : unSelectedColor;
            final date = days[i].$2;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  date.bookingDayName(days[i].$1.text),
                  style: context.textTheme.labelSmall,
                  height: 0,
                  color: color.withAppOpacity(0.7),
                ),
                AppText(
                  date.toDayAndMonthName(locale: "ar"),
                  style: context.textTheme.labelMedium,
                  textAlign: TextAlign.center,
                  color: disabled ? context.colors.surfaceContainer : color,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
