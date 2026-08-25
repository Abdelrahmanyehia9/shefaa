part of "../doctor_screen.dart";

class _DoctorStates extends StatelessWidget {
  const _DoctorStates();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItem(text: "وقت الانتظار 11 د", icon: AppIcons.time, context),
        _vDivider(context),
        _buildItem(text: " الكشف  300 جنيه", icon: AppIcons.wallet, context),
      ],
    );
  }

  Widget _vDivider(BuildContext context) => Container(
    color: context.colors.surfaceContainerLowest,
    height: UISizes.sp32,
    width: UISizes.sp1,
  );
  Widget _buildItem(
    BuildContext context, {
    required String text,
    required IconData icon,
  }) => AppIconText(
    text: text,
    icon: icon,
    iconColor: context.colors.primary,
    textStyle: context.textTheme.labelMedium,
    iconSize: UISizes.sp18,
  );
}
