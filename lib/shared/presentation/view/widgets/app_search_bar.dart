import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/search_field.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;

  final VoidCallback? onFilterTap;

  final String? hint;

  const AppSearchBar({super.key, this.hint, this.onFilterTap, this.controller});

  @override
  Widget build(BuildContext context) {
    final size = UISizes.h40;
    return Row(
      spacing: UISizes.w6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SearchField(hint: hint, height: size),
        ),
        AppChip(
          paddingVr: 0,
          paddingHr: 0,
          onTap: onFilterTap,
          height: size,
          width: size,
          radius: UISizes.r16,
          child: Icon(
            AppIcons.filters,
            size: UISizes.sp24,
            color: context.colors.onPrimary,
          ),
        ),
      ],
    );
  }
}
