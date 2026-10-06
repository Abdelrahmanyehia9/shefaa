import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class MyPaymentMethodScreen extends StatelessWidget {
  const MyPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const AppText("وسائل الدفع"),),
      body:  ResultView(
          mainAxisAlignment: MainAxisAlignment.start,
          size: UISizes.sp26,
          type: ResultType.noPaymentMethod),
    );
  }
}
