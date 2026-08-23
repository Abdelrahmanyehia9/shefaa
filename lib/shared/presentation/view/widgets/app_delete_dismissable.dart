import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_dismissable.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class AppDeleteDismissable extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onDelete;

  const AppDeleteDismissable({
    required super.key,
    this.onDelete,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AppDismissable(
      key: key,
      onDismissed: (_) => onDelete?.call(),
      startAction: const AppDismissAction(
        icon: AppIcons.delete,
        label: "حذف",
      ),
      child: child,
    );
  }

}
