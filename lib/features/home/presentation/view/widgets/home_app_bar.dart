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
              BlocBuilder(
                  bloc: sessionCubit,
                  builder:(_,_) {
                    final name = sessionCubit.currentUser?.firstname?? "" ;
                    return AppText("مرحبا $name 👋", style: context.textTheme.labelMedium, maxLines: 1,);
                  }),
              AppText(
                "كيف حالك اليوم ؟",
                style: context.textTheme.labelMedium,
                color: context.colors.surfaceContainer,
              ),
            ],
          ),
        ),
        const AppNotificationIcon(),
      ],
    );
  }
}
