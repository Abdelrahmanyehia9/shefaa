import 'package:flutter/material.dart';

import 'package:shefaa/core/helper/ui_sizes.dart';

class AppRefreshable extends StatelessWidget {
  final VoidCallback? onRefresh;
  final Widget child;

  const AppRefreshable({super.key, this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      strokeWidth: UISizes.sp2,
      onRefresh: () async {
        onRefresh?.call();
      },
      child: child,
    );
  }
}
