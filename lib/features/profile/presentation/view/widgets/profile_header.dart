part of "../profile_screen.dart";

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sessionCubit,
      builder:(context, s) {
        if(sessionCubit.isGuest){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText("اهلا بك فى شفاء", style: context.textTheme.titleLarge,fontSize: UISizes.sp20,),
              AppText("سجّل دخولك للمتابعة والاستمتاع بتجربة  أسهل وأسرع.", style: context.textTheme.labelLarge,
              color: context.colors.surfaceContainer,
              ),
              Gap.medium(),
              AppButton.filled(
                onTap: ()=>context.pushNamed(Routes.signIn),
               style: context.textTheme.titleLarge,
                  "تسجيل / تسجيل دخول",
              ),
            ],
          );
        }
        return Column(
        spacing: UISizes.h8,
        children: [
          UserEditAvatar(size: UISizes.sp96),
          AppText(sessionCubit.currentUser?.completeName, style: context.textTheme.labelLarge),
        ],
      );
      },
    );
  }
}
