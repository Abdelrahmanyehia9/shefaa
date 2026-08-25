part of "../clinic_screen.dart";

class _ClinicStates extends StatelessWidget {
  const _ClinicStates();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildItem(
          context,
          text: "343 شارع الامل , حمص ,سوريا",
          icon: AppIcons.bookingLocation,
        ),
        const Divider(),
        _buildItem(
          context,
          text: "من الأحد إلى الأربعاء، 6:00 م - 12:00 ص",
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
