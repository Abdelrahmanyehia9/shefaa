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
                builder: (_, _) => AppText(
                  "مرحبا ${sessionCubit.currentUser?.firstname ?? ""} 👋",
                  style: context.textTheme.labelMedium,
                  maxLines: 1,
                ),
              ),
              AppText(
                "كيف حالك اليوم ؟",
                style: context.textTheme.labelMedium,
                color: context.colors.surfaceContainer,
              ),
            ],
          ),
        ),
        BlocBuilder(
          bloc: sessionCubit,
          builder: (_, _) => Row(
            mainAxisSize: MainAxisSize.min,
            spacing: UISizes.w4,
            children: [
              if (sessionCubit.isGuest)
                AppButton.filled(
                  onTap: ()=>context.pushNamed(Routes.signIn),
                  style: context.textTheme.titleSmall,
                  fixedSize: Size(UISizes.w96, UISizes.sp32),
                  "تسجيل دخول",
                ),
              const AppNotificationIcon(),
            ],
          ),
        ),
      ],
    );
  }
}
