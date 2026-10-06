
import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_svg.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/overlay/bottom_sheets.dart';
import 'package:shefaa/core/components/overlay/popups.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_assets.dart';

class AuthGuard {
  AuthGuard._();

  static Future<void> run({
    required BuildContext context,
    required VoidCallback onAuthenticated,
  }) async {
    if (!sessionCubit.isGuest) {
      onAuthenticated();
      return;
    }

    final result = await Popups.show<bool>(child: Column(
      spacing: UISizes.h4,
      mainAxisSize: .min,
      children: [
        AppSvg.asset(AppAssets.authIllustration, width: UISizes.sp220,
        height: UISizes.sp220,
        ),
        AppText("تسجيل الدخول مطلوب",
        textAlign: TextAlign.center,
        style: context.textTheme.titleLarge,
        ),
        AppText(
          textAlign: TextAlign.center,
          "قم بتسجيل الدخول أولاً للاستفادة من هذه الميزة والوصول إلى جميع الخدمات والمميزات المتاحة لك داخل التطبيق.",
          style: context.textTheme.labelMedium,
          color: context.colors.surfaceContainer,
        ),
        Gap.medium(),
        Row(
          spacing: UISizes.w4,
          children: [
            Expanded(child: AppButton.filled("تسجيل الدخول", onTap: ()=> context.pop(true),)),
            Expanded(child: AppButton.outlined("الرجوع",
              onTap: ()=> context.pop(false),
              color: context.colors.primary,))
          ],
        )

      ],
    ) );
    if(!context.mounted)return ;
    if(result??false){
      context.pushNamed(Routes.signIn) ;
      return ;
    }

  }
}
