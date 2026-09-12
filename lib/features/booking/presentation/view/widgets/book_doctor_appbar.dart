part of '../book_doctor_screen.dart';

class _BookDoctorAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isFirst;
  final VoidCallback onBack;
  final int step;
  final int totalSteps;

  const _BookDoctorAppbar({
    required this.isFirst,
    required this.onBack,
    required this.step,
    required this.totalSteps,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: AppBackButton(onBack: onBack).appPaddingAll(8),
      title: Column(
        children: [
          const AppText('حجز موعد'),
          AppText(
            'خطوة ${step + 1} من $totalSteps',
            style: context.textTheme.titleSmall,
            color: context.colors.primary,
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
