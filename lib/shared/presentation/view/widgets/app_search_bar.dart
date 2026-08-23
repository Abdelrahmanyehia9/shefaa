import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/search_field.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller ;
  final VoidCallback? onFilterTap ;
  const AppSearchBar({super.key,this.onFilterTap ,this.controller});

  @override
  Widget build(BuildContext context) {
    final size = UISizes.h48 ;
    return Row(
      spacing: UISizes.w8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SearchField()),
        AppChip(
          paddingVr: 0,
          paddingHr: 0,
          onTap: onFilterTap,
          height: size*.85,
          width: size,
          child: Icon(
            AppIcons.filters,
            size: UISizes.sp24
            , color: context.colors.onPrimary,),
        )
      ],
    );
  }
}
