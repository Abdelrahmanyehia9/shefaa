import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_loader.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

part 'widgets/splash_brand_and_slogan.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      vPadding: 24,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          AppLoader(backgroundColor: Colors.transparent,
          size: UISizes.sp256,
            loop: false,
          ),
          const Spacer(),
          const _SplashBrandAndSlogan(),
        ],
      ),
    );
  }
}
