import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_highlight.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';

class AuthLayout extends StatelessWidget {
  final String title, description;
  final Widget form;
  final AppButton action;
  final Widget? footer;

  const AuthLayout({
    super.key,
    required this.title,
    required this.description,
    required this.form,
    this.footer,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          32.spaceVr,
          AppText(
            textAlign: TextAlign.center,
            title,
            style: context.textTheme.headlineMedium,
          ),
          AppTextHighLight(
            highlighterStyle: context.textTheme.labelMedium?.copyWith(
              color: context.colors.primary,
            ),
            textAlign: TextAlign.center,
            description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.surfaceContainer,
            ),
          ),
          form.appPaddingVr(24),
          action,
          ?footer?.paddingVr,
        ],
      ),
    );
  }
}
