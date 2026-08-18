import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class UserAvatar extends StatelessWidget {
  final String? image;
  final double? size;
  const UserAvatar({super.key, this.size, this.image});

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? UISizes.sp96;
    final Color color = context.colors.surfaceContainer;
    if (image.isNullOrEmpty) {
      return AppChip(
        shape: BoxShape.circle,
        width: size,
        height: size,
        color: color.light,
        child: Icon(AppIcons.profile, color: color, size: size * .6),
      );
    }
    return ClipOval(
      child: AppCachedNetworkImage(image, width: size, height: size),
    );
  }
}
