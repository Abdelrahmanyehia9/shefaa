part of "../splash_screen.dart";

class _SplashBrandAndSlogan extends StatelessWidget {
  const _SplashBrandAndSlogan();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppText(
                "شِفَاء",
                color: AppColors.white,
                height: 0,
                style: context.textTheme.displaySmall,
              )
              .animate(delay: 1400.ms)
              .fadeIn(duration: 500.ms, curve: Curves.easeOut)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOut,
              ),
          AppText(
                "دكتورك صار اقرب",
                style: context.textTheme.headlineSmall,
                height: 0,
                color: AppColors.white,
              )
              .animate(delay: 1800.ms)
              .fadeIn(duration: 500.ms, curve: Curves.easeOut)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOut,
              ),
        ],
      ),
    );
  }
}
