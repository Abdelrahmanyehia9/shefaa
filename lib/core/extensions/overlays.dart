import 'package:flutter/cupertino.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/overlay/bottom_sheets.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

extension OverlaysEXT on BuildContext {


  Future<bool> showWarningBottomSheet({String?  title, required String message })async{
  final result = await  BottomSheets.show<bool>(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
            Gap.medium(),
            AppText(
              style: textTheme.labelMedium,
              color: colors.surfaceContainer,
              message
            ),
            Gap.medium(),
            Row(
              spacing: UISizes.w8,
              children: [
                Expanded(child: AppButton.filled("تاكيد",onTap: ()=>pop(true),)),
                Expanded(child: AppButton.outlined("الغاء", color:colors.primary,onTap:()=> pop(false),))
              ],
            )
          ],
        )
    );
  return result ?? false ;
  }













}