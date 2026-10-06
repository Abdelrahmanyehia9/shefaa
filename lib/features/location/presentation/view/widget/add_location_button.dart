import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class AddLocationButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isMaximum ;
  const AddLocationButton({super.key, this.isMaximum = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h4,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          onTap: onTap ,
          isDisabled: isMaximum,
          padding: EdgeInsets.symmetric(
              vertical: UISizes.sp12, horizontal: UISizes.sp16),
          alignment: AlignmentDirectional.centerStart,
          child: AppIconText(
            color: context.colors.onPrimary,
            textStyle: context.textTheme.titleMedium,
            icon: AppIcons.add,
            text: "اضافة عنوان جديد",
          ),
        ),
        if(isMaximum)
          AppIconText(
            textStyle: context.textTheme.titleSmall,
            iconSize: UISizes.sp16,
            icon: AppIcons.error,
            color: context.colors.error,
            text: "لقد وصلت للحد الاقصي من العناوين المحفوظة",
          )
      ],
    );
  }
}
