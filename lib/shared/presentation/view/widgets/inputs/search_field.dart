import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      height: UISizes.h48,
      padding: EdgeInsets.zero,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: context.colors.surfaceContainerLow
        ), 
        borderRadius: BorderRadius.circular(UISizes.r12)
      ),
      prefix: Icon(AppIcons.search, size: UISizes.sp20,
        color: context.colors.surfaceContainer,
     ),
      hintText: "بحث عن دكتور,تخصص او عيادة....",
      hintStyle: context.textTheme.bodyMedium?.copyWith(
        color: context.colors.surfaceContainer
      ),
    );
  }
}
