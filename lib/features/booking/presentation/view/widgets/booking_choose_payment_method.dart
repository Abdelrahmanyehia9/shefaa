import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_constants.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_cubit.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_states.dart';

class BookingChoosePaymentMethod extends StatefulWidget {

  const BookingChoosePaymentMethod({super.key});

  @override
  State<BookingChoosePaymentMethod> createState() =>
      _BookingChoosePaymentMethodState();
}

class _BookingChoosePaymentMethodState
    extends State<BookingChoosePaymentMethod> {
  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionHeader(title: "طرق الدفع المتاحة"),
      _EnabledMethods(),
      _UpcomingMethods(),
    ],
  );

}

class _EnabledMethods extends StatelessWidget {
  const _EnabledMethods();

  @override
  Widget build(BuildContext context) => BlocBuilder<CreateBookingCubit, CreateBookingStates>(
    builder:(context, s) {
      if(s is CreateBookingStateInitial){
        return Column(
          children: AppConstants.enabledPaymentMethods
              .map(
                (m) {
              bool isSelected = m == s.payMethod ;
              return _PaymentMethodChip(
                method: m,
                selected: isSelected,
                onTap: () {
                  final cubit = context.read<CreateBookingCubit>();
                  cubit.changePaymentMethod(m);
                },
              );
            },
          )
              .toList(),
        );
      }
     return const SizedBox.shrink();
    },
  );
}

class _UpcomingMethods extends StatelessWidget {
  const _UpcomingMethods();

  static final List<PaymentMethod> _upComing = PaymentMethod.values
      .where((method) => !AppConstants.enabledPaymentMethods.contains(method))
      .toList();

  @override
  Widget build(BuildContext context) {
    if (_upComing.isEmpty) return const SizedBox.shrink();
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Opacity(
          opacity: 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._upComing.map(
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
        ),
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
            style: selected
                ? context.textTheme.titleMedium
                : context.textTheme.labelMedium,
            color: selected
                ? colors.primary
                : enabled
                ? null
                : colors.surfaceContainerLow,
          ),
          if (selected)
            Icon(AppIcons.checked, size: UISizes.sp20, color: colors.primary),
        ],
      ),
    );
  }
}
