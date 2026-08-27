import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_constants.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class BookingChoosePaymentMethod extends StatefulWidget {
  final ValueChanged<PaymentMethod>? onChange;
  final PaymentMethod method;

  const BookingChoosePaymentMethod({
    super.key,
    required this.method,
    this.onChange,
  });

  @override
  State<BookingChoosePaymentMethod> createState() =>
      _BookingChoosePaymentMethodState();
}

class _BookingChoosePaymentMethodState
    extends State<BookingChoosePaymentMethod> {
  late final _selectedMethod = ValueNotifier(widget.method);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _selectedMethod,
    child: const SectionHeader(title: "طرق الدفع المتاحة"),
    builder: (_, selected, child) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child!,
        ...PaymentMethod.values.map((method) {
          final selected = method == _selectedMethod.value;
          final enabled = AppConstants.enabledPaymentMethods.contains(method);

          return AppChip(
            marginVr: UISizes.h4,
            height: UISizes.h48,
            onTap: enabled && !selected
                ? () {
                    _selectedMethod.value = method;
                    widget.onChange?.call(method);
                  }
                : null,
            color: selected
                ? context.colors.primary.softLight
                : Colors.transparent,
            borderColor: selected
                ? context.colors.primary
                : enabled
                ? context.colors.surfaceContainer
                : context.colors.surfaceContainerLowest,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  method.text,
                  style: context.textTheme.labelMedium,
                  color: selected
                      ? context.colors.primary
                      : enabled
                      ? null
                      : context.colors.surfaceContainer,
                ),
                if (selected)
                  Icon(
                    AppIcons.checked,
                    size: UISizes.sp20,
                    color: context.colors.primary,
                  ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  @override
  void dispose() {
    _selectedMethod.dispose();
    super.dispose();
  }
}
