import 'package:flutter/material.dart';
import 'package:shefaa/core/components/overlay/snack_bars.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/theme.dart';

extension SnackBarExt on BuildContext {
  void showSnackBars({required String message, String title = ""}) {
    return SnackBars.custom(context: this, message, title: title);
  }

  void successBar({
    required String message,
    String title = "تم بنجاح",
  }) {
    return SnackBars.success(context: this, message: message, title: title);
  }

  void errorBar(AppException ex, {String title = "حدث خطأ"}) {
    return SnackBars.error(context: this, message: ex.message, title: title);
  }

  void warningBar({
    required String message,
    String title = "تحذير",
  }) {
    return SnackBars.warning(context: this, message: message, title: title);
  }

  void flash({required String message, Color? color, Color? textColor}) {
    SnackBars.custom(
      message,
      context: this,
      duration: const Duration(seconds: 1),
      showGradient: false,
      radius: 12,
      backgroundColor: color ?? colors.surfaceContainerHighest,
      titleStyle: textTheme.bodyMedium?.copyWith(
        color: textColor ?? scaffoldBackgroundColor,
      ),
    );
  }
}