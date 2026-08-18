import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_svg.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_highlight.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/text_styles.dart';
import 'package:shefaa/features/intro/data/models/onboarding.dart';

class OnboardingItem extends StatelessWidget {
  final Onboarding item;

  const OnboardingItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSvg.asset(item.image, width: UISizes.sp320, height: UISizes.sp320),
        16.spaceVr,
        AppTextHighLight(
          textAlign: TextAlign.center,
          style: context.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeightHelper.bold,
          ),
          item.title,
          highlighterStyle: context.textTheme.headlineLarge?.copyWith(
            color: context.colors.primary,
            fontWeight: FontWeightHelper.bold,
          ),
        ),
        8.spaceVr,
        AppText(
          textAlign: TextAlign.center,
          item.description,
          color: context.colors.surfaceContainer,
          style: context.textTheme.bodyLarge,
          height: 0,
        ),
      ],
    );
  }
}
