import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UISizes.r16),
        borderSide: BorderSide.none,
      ),
      prefix: Icon(AppIcons.search, size: UISizes.sp20),
      hintText: "البحث ",
    );
  }
}
