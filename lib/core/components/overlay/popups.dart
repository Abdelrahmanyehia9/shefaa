import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/services/navigation_service.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class Popups {
  static Future<T?> show<T>({
    BuildContext? context,
    bool showCloseButton = false,
    final Color? patternColor,
    Color? backgroundColor,
    double borderRadius = 16,
    List<BoxShadow>? shadow,
    required Widget child,
    bool dismissable = true,
  }) {
    return showDialog<T>(
      context: context ?? NavigationService.context!,
      barrierDismissible: dismissable,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Center(
          child: SizedBox(
            width: size.width * 0.9,
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: shadow,
                      color:
                          backgroundColor ??
                          Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: child,
                        ),
                        if (showCloseButton)
                          GestureDetector(
                            onTap: context.pop,
                            child: CircleAvatar(
                              radius: UISizes.r22,
                              backgroundColor: context.colors.primary,
                              child: Icon(
                                AppIcons.close,
                                color: context.colors.onPrimary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showWarning({
    Widget? customIcon,
    Widget? customBody,
    Widget? customActions,
    IconData icon = AppIcons.warning,
    Color iconColor = AppColors.warning,
    String title = "هل انت متاكد",
    String message = "من هذا الطلب",
    void Function()? onConfirm,
  }) async {
    final result = await Popups.show(
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            spacing: UISizes.h4,
            children: [
              customIcon ?? Icon(icon, size: UISizes.sp72, color: iconColor),
              Gap.small(),
              if (customBody == null) ...[
                AppText(
                  title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelLarge,
                ),
                AppText(
                  message,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
              ] else
                customBody,
              Gap.medium(),
              customActions ??
                  Row(
                    spacing: UISizes.sp4,
                    children: [
                      Expanded(
                        child: AppButton.filled(
                          "تاكيد",
                          onTap: () {
                            context.pop(true);
                          },
                        ),
                      ),
                      Expanded(
                        child: AppButton.outlined(
                          "الغاء",
                          onTap: () {
                            context.pop(false);
                          },
                          color: context.colors.primary,
                        ),
                      ),
                    ],
                  ),
            ],
          );
        },
      ),
    );
    if (result == true) {
      onConfirm?.call();
      return;
    }
  }
}
