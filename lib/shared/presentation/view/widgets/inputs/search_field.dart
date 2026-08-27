import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class SearchField extends StatelessWidget {
  final String? hint;
  final double height ;
  const SearchField({super.key, required this.height, this.hint});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      height: height,
      filled: true,
      filledColor: context.scaffoldBackgroundColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colors.surfaceContainerLow, width: .5),
        borderRadius: BorderRadius.circular(UISizes.r16),
      ),
      prefix: Icon(
        AppIcons.search,
        size: UISizes.sp20,
        color: context.colors.surfaceContainer,
      ),
      hintText: hint ?? "بحث عن دكتور,تخصص او عيادة....",
      hintStyle: context.textTheme.labelMedium?.copyWith(
        color: context.colors.surfaceContainer,
      ),
    );
  }
}
