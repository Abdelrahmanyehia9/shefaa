part of "../profile_screen.dart";

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h8,
      children: [
        UserEditAvatar(size: UISizes.sp96),
        AppText("خالد عبدالرحمن", style: context.textTheme.labelLarge),
      ],
    );
  }
}
