import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class BookingAmountToPay extends StatelessWidget {
  const BookingAmountToPay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "مطلوب للدفع"),
        AppChip(
          width: double.infinity,
          paddingVr: UISizes.h12,
          paddingHr: UISizes.w12,
          child: AppIconText(
            icon: AppIcons.wallet,
            color: context.colors.onPrimary,
            text: "300 جنيه",
            textStyle: context.textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
