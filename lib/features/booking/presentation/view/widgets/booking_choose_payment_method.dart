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

  const BookingChoosePaymentMethod({
    super.key,
    this.onChange,
  });

  @override
  State<BookingChoosePaymentMethod> createState() =>
      _BookingChoosePaymentMethodState();
}

class _BookingChoosePaymentMethodState
    extends State<BookingChoosePaymentMethod> {
  late final _selectedMethod = ValueNotifier(AppConstants.enabledPaymentMethods.first);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionHeader(title: "طرق الدفع المتاحة"),
      _EnabledMethods(
        selectedMethod: _selectedMethod,
        onChange: widget.onChange,
      ),
      const _UpcomingMethods(),
    ],
  );

  @override
  void dispose() {
    _selectedMethod.dispose();
    super.dispose();
  }
}

class _EnabledMethods extends StatelessWidget {
  final ValueNotifier<PaymentMethod> selectedMethod;
  final ValueChanged<PaymentMethod>? onChange;

  const _EnabledMethods({
    required this.selectedMethod,
    this.onChange,
  });

  @override

  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: selectedMethod,
    builder: (_, selected, _) => Column(
      children: AppConstants.enabledPaymentMethods
          .map(
            (method) => _PaymentMethodChip(
          method: method,
          selected: method == selected,
          onTap: () {
            if (method == selected) return;
            selectedMethod.value = method;
            onChange?.call(method);
          },
        ),
      )
          .toList(),
    ),
  );
}

class _UpcomingMethods extends StatelessWidget {
  const _UpcomingMethods();

  static final List<PaymentMethod> _upComing = PaymentMethod.values
      .where(
  (method) =>
  !AppConstants.enabledPaymentMethods.contains(method),
  ).toList();

  @override
  Widget build(BuildContext context) {
    if(_upComing.isEmpty)return const SizedBox.shrink() ;
    return Stack(
    alignment: AlignmentGeometry.center,
    children: [
      Opacity(
        opacity: 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._upComing
                .map(
                  (method) => _PaymentMethodChip(
                method: method,
                selected: false,
                enabled: false,
              ),
            ),
          ],
        ),
      ),
      AppText(
         "سيتم توفرها قريبا..",
        color: context.colors.surfaceContainerHigh,
        style: context.textTheme.labelSmall,
      )
    ],
  );
  }
}

class _PaymentMethodChip extends StatelessWidget {
  final PaymentMethod method;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;

  const _PaymentMethodChip({
    required this.method,
    required this.selected,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppChip(
      marginVr: UISizes.h4,
      height: UISizes.h48,
      onTap: enabled ? onTap : null,
      color: selected ? colors.primary.light : Colors.transparent,
      borderColor: selected
          ? colors.primary
          : enabled
          ? colors.surfaceContainerLow
          : colors.surfaceContainerLowest,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            method.text,
            style:selected ?context.textTheme.titleMedium : context.textTheme.labelMedium,
            color: selected
                ? colors.primary
                : enabled
                ? null
                : colors.surfaceContainerLow,
          ),
          if (selected)
            Icon(
              AppIcons.checked,
              size: UISizes.sp20,
              color: colors.primary,
            ),
        ],
      ),
    );
  }
}