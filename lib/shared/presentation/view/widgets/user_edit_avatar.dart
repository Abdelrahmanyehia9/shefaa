import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_widget_overlay.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class UserEditAvatar extends StatelessWidget {
  final double? size;
  const UserEditAvatar({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? UISizes.sp110;
    return AppWidgetOverlay(
      overlay: [(AlignmentGeometry.bottomStart, _buildEditIcon(size))],
      child: UserAvatar(size: size),
    );
  }

  Widget _buildEditIcon(double size) => CircleIconButton(
    AppIcons.edit,
    iconSize: size * .2,
    padding: UISizes.sp6,
  );
}
