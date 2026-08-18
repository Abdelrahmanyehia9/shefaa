import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';

class AuthSwitcher extends StatelessWidget {
  final bool isSignup;
  const AuthSwitcher({super.key, this.isSignup = false});

  @override
  Widget build(BuildContext context) {
    final String message = isSignup ? "لديك حساب بالفعل؟" : "ليس لديك حساب؟";
    final String action = isSignup ? "تسجيل الدخول" : "إنشاء حساب";
    return Row(
      spacing: UISizes.w8,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, style: context.textTheme.labelMedium),
        AppClick(
          onTap: () => _onToggle(context),
          child: Text(
            action,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _onToggle(BuildContext context) {
    if (isSignup) {
      context.pushNamedAndRemoveUntil(Routes.signIn);
    } else {
      context.pushNamed(Routes.signUp);
    }
  }
}
