part of "../clinic_screen.dart";

class _ClinicStates extends StatelessWidget {
  final LocationEntity location ;
  final List<WorkingHourEntity> workingHours ;
  const _ClinicStates({required this.location ,required this.workingHours});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(location.name!=null)
        _buildItem(
          context,
          text: location.name!,
          icon: AppIcons.bookingLocation,
        ),
        if(location.name!=null && workingHours.isNotEmpty)
        const Divider(),
        if(workingHours.isNotEmpty)
        _buildItem(
          context,
          text: workingHours.formattedWorkingHour,
          icon: AppIcons.timeFilled,
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String text,
    required IconData icon,
  }) => AppIconText(
    text: text,
    icon: icon,
    expandedText: true,
    iconColor: context.colors.primary,
    textStyle: context.textTheme.labelMedium,
    iconSize: UISizes.sp18,
  );
}
