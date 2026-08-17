import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_logo.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';

part 'widgets/splash_brand_and_slogan.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      vPadding: 24,
      backgroundColor: AppColors.primary600,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Animate(
            delay: 500.ms,
            effects: [
              FadeEffect(
                delay: 400.ms,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),
              ScaleEffect(
                begin: const Offset(0.6, 0.6),
                end: const Offset(1, 1),
                duration: 1000.ms,
                curve: Curves.easeOutBack,
              ),
            ],
            child: AppLogo(size: UISizes.sp110, color: AppColors.white),
          ),
          const Spacer(),
          const _SplashBrandAndSlogan(),
        ],
      ),
    );
  }
}
