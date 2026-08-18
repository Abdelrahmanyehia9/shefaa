import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_highlight.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/utils/app_assets.dart';

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
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.sizeOf(context).height,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.6,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        context.scaffoldBackgroundColor.withAppOpacity(.3),
                        context.scaffoldBackgroundColor.withAppOpacity(.6),
                      ],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    AppAssets.medicalPattern,
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.1),
                  ),
                ),
              ),
            ),
            Column(
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
            ).paddingHr,
          ],
        ),
      ),
    );
  }
}
