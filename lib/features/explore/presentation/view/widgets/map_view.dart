import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.grey100,
      child: Center(
        child: Icon(
          AppIcons.locationFilled,
          size: UISizes.sp32,
          color: context.colors.secondary,
        ),
      ),
    );
  }
}
