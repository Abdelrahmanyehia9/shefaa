import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      appBar: AppBar(
        title: const AppText("الاشعارات"),
        // actions: const [AppChip(title: "2 جديد")],
      ),
      body: SingleChildScrollView(
        child: ResultView(type: ResultType.noNotification, size: UISizes.sp24,)
      ),
    );
  }
}
