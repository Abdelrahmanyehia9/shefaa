import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/clinic_header.dart';

class BookingClinicInfo extends StatelessWidget {
  const BookingClinicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ClinicHeader(),
          AppChip(
            color: context.colors.primary,
            monochromatic: true,
            child: AppIconText(
              expandedText: true,
              color: context.colors.primary,
              textStyle: context.textTheme.labelMedium,
              text:
                  "سيتم ارسال بيانات العيادة والموقع بالتفصيل بعد تاكيد الحجز",
              icon: AppIcons.lamp,
            ),
          ),
        ],
      ).appPaddingAll(8),
    );
  }
}
