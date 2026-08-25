import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/notifications/presentation/view/widgets/notification_per_time.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      appBar: AppBar(
        title: const AppText("الاشعارات"),
        actions: const [AppChip(title: "2 جديد")],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: UISizes.h16,
          children: [
            const NotificationPerTime(label: "اليوم"),
            const NotificationPerTime(label: "الامس"),
            NotificationPerTime(
              label: DateTime.now()
                  .subtract(const Duration(days: 4))
                  .toNameOfDayAndMonth(locale: "AR"),
            ),
          ],
        ),
      ),
    );
  }
}
