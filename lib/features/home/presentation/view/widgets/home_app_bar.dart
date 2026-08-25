part of '../home_screen.dart';

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w8,
      children: [
        UserAvatar(size: UISizes.sp56),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText("مرحبا Ahmed 👋", style: context.textTheme.labelMedium),
              AppText("كيف حالك اليوم ؟", style: context.textTheme.bodyMedium),
            ],
          ),
        ),
        const AppNotificationIcon(),
      ],
    );
  }
}
