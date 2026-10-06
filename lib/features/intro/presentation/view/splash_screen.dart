import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_loader.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

part 'widgets/splash_brand_and_slogan.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => await initUserSession(),
    );
    super.initState();
  }

  Future<void> initUserSession() async {
    await Future.delayed(5.seconds, () {
      sessionCubit.init();
    });
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          AppLoader(
            backgroundColor: Colors.transparent,
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
