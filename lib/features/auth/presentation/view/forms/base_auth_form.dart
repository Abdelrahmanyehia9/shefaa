import 'package:flutter/material.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class BaseAuthForm extends StatelessWidget {
  final List<Widget> fields;
  final GlobalKey<FormState>? formKey;
  final Widget? footer;
  const BaseAuthForm({
    super.key,
    this.formKey,
    required this.fields,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(spacing: UISizes.sp12, children: [...fields, ?footer]),
    );
  }
}
