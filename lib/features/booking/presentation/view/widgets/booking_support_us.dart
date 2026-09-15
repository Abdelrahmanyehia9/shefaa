import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_constants.dart';
import 'package:shefaa/features/booking/presentation/controller/support_us_controller.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/amount_field.dart';

class BookingSupportUs extends StatelessWidget {
  const BookingSupportUs({
    super.key,
    required this.controller,
    this.onCustomAmount,
  });

  final SupportUsController controller;
  final VoidCallback? onCustomAmount;

  void _select(int index) {
    if (index == SupportUsController.custom) onCustomAmount?.call();
    controller.select(index);
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) {
      final selected = controller.selectedIndex;
      return Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: "قم بدعمنا",
              paddingVr: 0,
              action: "تفاصيل",
            ),
            AppText(
              "دعمك لنا يساعدنا في تقديم خدمات بشكل أفضل",
              style: context.textTheme.labelSmall,
              color: context.colors.surfaceContainer,
            ),
            Gap.medium(),
            Column(
              spacing: UISizes.h16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: UISizes.sp4,
                  runSpacing: UISizes.sp4,
                  children: [
                    ...AppConstants.supportPay.indexed.map(
                      (e) => _chip(
                        context,
                        "${e.$2.toStringAsFixed(1)} ج.م",
                        e.$1,
                        selected,
                      ),
                    ),
                    _chip(
                      context,
                      "مبلغ آخر",
                      SupportUsController.custom,
                      selected,
                    ),
                  ],
                ),
                AmountField(
                      controller: controller.amountController,
                      min: controller.min,
                      max: controller.max,
                    )
                    .animate(target: controller.isCustomSelected ? 1 : 0)
                    .fadeIn(duration: 250.ms)
                    .slideY(begin: -.2, end: 0, duration: 250.ms)
                    .scaleY(
                      begin: 0,
                      end: 1,
                      alignment: Alignment.topCenter,
                      duration: 250.ms,
                      curve: Curves.easeOut,
                    ),
              ],
            ),
          ],
        ),
      );
    },
  );

  Widget _chip(BuildContext context, String text, int index, int? selected) {
    final isSelected = index == selected;
    return AppChip(
      title: text,
      radius: UISizes.sp8,
      paddingHr: UISizes.w24,
      paddingVr: UISizes.h8,
      color: isSelected ? context.colors.primary.light : Colors.transparent,
      titleStyle: context.textTheme.labelMedium,
      titleColor: isSelected
          ? context.colors.primary
          : context.colors.surfaceContainerHigh,
      borderColor: isSelected
          ? context.colors.primary
          : context.colors.surfaceContainerLowest,
      onTap: () => _select(index),
    );
  }
}
