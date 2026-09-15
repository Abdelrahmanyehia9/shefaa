part of '../book_doctor_screen.dart';

class _BookDoctorAction extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final ValueNotifier<String?> validation;

  const _BookDoctorAction({
    required this.isFirst,
    required this.isLast,
    required this.onNext,
    required this.validation,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: validation,
      builder: (context, message, child) {
        return Column(
          spacing: UISizes.h8,
          children: [
            Row(
              spacing: UISizes.w8,
              children: [
                Expanded(
                  child: AppButton.filled(
                    isDisabled: message != null,
                    isLast ? 'تأكيد الحجز' : 'التالي',
                    onTap: onNext,
                  ),
                ),
                if (!isFirst)
                  Expanded(
                    child: AppButton.outlined(
                      'السابق',
                      onTap: onPrevious,
                      color: context.colors.primary,
                    ),
                  ),
              ],
            ),
            Visibility(
              visible: message != null,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: AppIconText(
                text: message,
                icon: AppIcons.error,
                iconSize: UISizes.sp16,
                textStyle: context.textTheme.titleSmall,
                color: context.colors.error,
              ),
            ),
          ],
        );
      },
    );
  }
}
