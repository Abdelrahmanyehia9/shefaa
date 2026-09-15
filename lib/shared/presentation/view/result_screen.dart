import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class ResultScreenArgs {
  final ResultType type;
  final Widget Function(BuildContext context)? footer;
  final Widget? customIcon;
  final String? customSvg;
  final String? message;
  final MainAxisAlignment? mainAxisAlignment;
  const ResultScreenArgs({
    required this.type,
    required this.footer,
    this.customIcon,
    this.customSvg,
    this.message,
    this.mainAxisAlignment,
  });
}

class ResultScreen extends StatelessWidget {
  final ResultScreenArgs args;

  const ResultScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      topPadding: false,
      vPadding: 0,
      appBar: AppBar(),
      body: ResultView(
        type: args.type,
        size: UISizes.sp26,
        message: args.message,
        mainAxisAlignment: args.mainAxisAlignment ?? MainAxisAlignment.start,
        customIcon: args.customIcon,
        customSvg: args.customSvg,
        footer: args.footer?.call(context),
      ),
    );
  }
}
