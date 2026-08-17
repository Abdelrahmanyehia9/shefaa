import 'package:flutter/material.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const AppCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? EdgeInsets.all(UISizes.sp16),
        child: child,
      ),
    );
  }
}
