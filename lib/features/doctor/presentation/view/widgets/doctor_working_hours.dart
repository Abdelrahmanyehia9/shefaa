part of '../doctor_screen.dart';

class _DoctorWorkingHours extends StatelessWidget {
  const _DoctorWorkingHours();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final from = DateTime(now.year, now.month, now.day, 20); // 8 PM
    final to = DateTime(now.year, now.month, now.day + 1); // 12 AM

    return Column(
      children: [
        const SectionHeader(title: "ساعات العمل"),
        const Divider(),
        _dayWorkingHour("الأحد", context: context, from: from, to: to),
        _dayWorkingHour("الاثنين", context: context, from: from, to: to),
        _dayWorkingHour("الثلاثاء", context: context),
        _dayWorkingHour("الأربعاء", context: context, from: from, to: to),
        _dayWorkingHour("الخميس", context: context, from: from, to: to),
        _dayWorkingHour("الجمعة", context: context),
        _dayWorkingHour("السبت", context: context),
      ],
    );
  }

  Widget _dayWorkingHour(
    String day, {
    required BuildContext context,
    DateTime? from,
    DateTime? to,
  }) {
    final isHoliday = from == null || to == null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          day,
          style: context.textTheme.bodyMedium,
          color: context.colors.surfaceContainer,
        ),
        AppText(
          isHoliday
              ? "ـــ"
              : "${from.time12Only(locale: "AR")} - ${to.time12Only(locale: "AR")}",
          style: context.textTheme.labelMedium,
        ),
      ],
    );
  }
}
