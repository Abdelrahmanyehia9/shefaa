import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_assets.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class SnackBars {
  const SnackBars._();
  static void custom(
    String message, {
    required BuildContext context,
    Color backgroundColor = AppColors.primary,
    Color borderColor = Colors.transparent,
    Color titleColor = Colors.white,
    Color messageColor = Colors.white,
    String? title,
    IconData? icon,
    bool showGradient = true,
    double radius = 0,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    Duration duration = const Duration(milliseconds: 1200),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        duration: duration,
        behavior: behavior,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(UISizes.sp12),
        ),
        content: AnimatedContainer(
          duration: duration,
          curve: Curves.bounceOut,
          padding: EdgeInsets.symmetric(
            horizontal: UISizes.w12,
            vertical: UISizes.h12,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            image: DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.03,
                colorFilter: ColorFilter.mode(backgroundColor.lighten(0.8), BlendMode.dstIn),
                image: const AssetImage(AppAssets.medicalPattern)),
            borderRadius: BorderRadius.circular(radius),
            gradient: showGradient
                ? LinearGradient(
                    colors: [backgroundColor, backgroundColor.darken(0.05)],
                  )
                : null,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white),
                const Gap(12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null && title.isNotEmpty)
                      AppText(
                        title,
                        color: titleColor,
                        style: titleStyle ?? context.textTheme.titleMedium,
                      ),
                    AppText(
                      message,
                      color: messageColor,
                      maxLines: 2,
                      style: messageStyle ?? context.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      snackBarAnimationStyle: const AnimationStyle(
        curve: Curves.bounceIn,
        reverseCurve: Curves.bounceOut,
        duration: Duration(milliseconds: 600),
      ),
    );
  }

  static void success({
    required BuildContext context,
    required String message,
    String title = "",
  })
  {
    custom(
      message,
      context: context,
      backgroundColor: AppColors.success,
      title: title,
      icon: AppIcons.checked,
    );
  }

  static void error({
    required BuildContext context,
    required String message,
    String title = "حدث خطا",
  })
  {
    custom(
      message,
      context: context,
      backgroundColor: context.colors.error,
      title: title,
      icon: AppIcons.error,
    );
  }

  static void warning({
    required BuildContext context,
    required String message,
    String title = "تحذير",
  })
  {
    custom(
      message,
      context: context,
      backgroundColor: AppColors.warning,
      title: title,
      icon: AppIcons.warning,
    );
  }
   static void flashBar(String message, BuildContext context , {Widget? icon}){
    final backGround = context.colors.primary ;
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           elevation: 0,
           width: context.width*.8,
           padding: EdgeInsets.zero,
           backgroundColor: Colors.transparent,
           duration: const Duration(milliseconds: 800),
           behavior: SnackBarBehavior.floating,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(UISizes.sp12),
           ),
           content: AnimatedContainer(
             duration: const Duration(milliseconds: 800),
             curve: Curves.ease,
             padding: EdgeInsets.all(UISizes.sp8),
             decoration: BoxDecoration(
               color: backGround,
               borderRadius: BorderRadius.circular(UISizes.sp12),
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               mainAxisSize: MainAxisSize.min,
               children: [

                 AppText(message,
                                  style: context.textTheme.titleMedium,
                                    color: context.colors.onPrimary,

                                  ),
                 if (icon != null) ...[
                   const Gap(12),

                   icon,
                 ],
               ],
             ),

           ),
         ),
       snackBarAnimationStyle: const AnimationStyle(
         curve: Curves.linear,
         reverseCurve: Curves.linear,
         duration: Duration(milliseconds: 800),
       ),

     );
   }
}
