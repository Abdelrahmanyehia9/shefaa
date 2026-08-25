import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_highlight.dart';
import 'package:shefaa/core/enum/notification_type.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/widgets/app_delete_dismissable.dart';

class NotificationCard extends StatelessWidget {
  final NotificationType type;
  final bool isRead;
  const NotificationCard({
    super.key,
    this.isRead = true,
    this.type = NotificationType.appointmentConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    final color = type.color;
    return AppDeleteDismissable(
      key: const ValueKey("k2"),
      child: ColoredBox(
        color: isRead ? Colors.transparent : color.veryLight,
        child: Row(
          spacing: UISizes.w12,
          children: [
            AppChip(
              paddingHr: UISizes.sp16,
              paddingVr: UISizes.sp16,
              color: color.light,
              shape: BoxShape.circle,
              child: Icon(type.icon, color: color, size: UISizes.sp32),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        "تم تاكيد حجزك",
                        style: context.textTheme.labelMedium,
                      ),
                      Text(
                        DateTime.now()
                            .subtract(400000.ms)
                            .time12Only(locale: "AR"),
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  AppTextHighLight(
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.surfaceContainer,
                    ),
                    highlighterStyle: context.textTheme.bodyMedium,
                    "تم تاكيد الحجز مع *د / خالد احمد*  عيادة حمص يوم*12 اغسطس* كن فى الميعاد",
                  ),
                ],
              ),
            ),
          ],
        ).paddingAll,
      ),
    );
  }
}
