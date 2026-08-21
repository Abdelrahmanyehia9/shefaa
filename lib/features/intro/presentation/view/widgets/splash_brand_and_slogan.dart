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
                color: context.colors.primary,
                height: 0,
                style: context.textTheme.displaySmall,
              )
              .animate(delay: 700.ms)
              .fadeIn(duration: 700.ms, curve: Curves.easeOut)
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
                color: context.colors.surfaceContainerHigh,
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
