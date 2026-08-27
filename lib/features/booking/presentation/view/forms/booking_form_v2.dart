import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_patient_info.dart';

class BookingFormV2 extends StatelessWidget {
  const BookingFormV2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AppStaggeredAnimation(
        children: [
          const BookingPatientInfo(),
          AppChip(
            color: AppColors.warning,
            monochromatic: true,
            child: AppIconText(
              icon: AppIcons.error,
              color: AppColors.warning,
              textStyle: context.textTheme.labelMedium,
              expandedText: true,
              text:
                  "يرجى التأكد من صحة رقم الهاتف، وسيتم التواصل مع المريض لتأكيد الحجز .",
            ),
          ),
        ],
      ),
    );
  }
}
