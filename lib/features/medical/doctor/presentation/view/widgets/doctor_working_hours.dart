part of '../doctor_screen.dart';

class _DoctorWorkingHours extends StatelessWidget {
  final List<WorkingHourEntity> workingHours;

  const _DoctorWorkingHours({required this.workingHours});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "ساعات العمل"),
        const Divider(),
        if (workingHours.isEmpty)
          AppText("لا توجد مواعيد متاحة", style: context.textTheme.bodyMedium)
        else
          ...workingHours.map((e) {
            return _dayWorkingHour(
              e.weekday.text,
              context: context,
              from: e.from.formatted,
              to: e.to.formatted,
            );
          }),
      ],
    );
  }

  Widget _dayWorkingHour(
    String day, {
    required BuildContext context,
    String? from,
    String? to,
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
          isHoliday ? "اجازة" : "$from - $to",
          style: context.textTheme.labelMedium,
        ),
      ],
    );
  }
}
