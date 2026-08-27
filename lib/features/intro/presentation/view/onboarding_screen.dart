import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_slider_dots.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/intro/data/models/onboarding.dart';
import 'package:shefaa/features/intro/presentation/view/widgets/onboarding_item.dart';
import 'package:shefaa/shared/presentation/mixin/page_controller_mixin.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with PageControllerMixin {
  final items = Onboarding.data;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      body: Column(
        children: [
          Visibility(
            visible: !isLast,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: AppButton.text(
              'تخطي',
              onTap: onFinish,
              style: context.textTheme.bodyLarge,
              textColor: context.colors.surfaceContainerHigh,
              margin: EdgeInsets.all(UISizes.sp24),
              align: AlignmentGeometry.topEnd,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              itemCount: items.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (_, i) => AnimatedBuilder(
                animation: pageController,
                builder: (context, child) {
                  final isVisible = pageController.isFullVisible(i);
                  return OnboardingItem(
                    item: items[i],
                    isFullVisible: isVisible,
                  ).paddingHr;
                },
              ),
            ),
          ),
          Column(
            spacing: UISizes.sp24,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppSliderDots(
                total: items.length,
                currentIndex: _currentIndex,
                width: (_) => UISizes.sp20,
                margin: UISizes.w2,
              ),
              Row(
                spacing: UISizes.w8,
                children: [
                  Expanded(child: AppButton.filled("التالى", onTap: next)),
                  if (!isFirst)
                    Expanded(
                      child: AppButton.outlined(
                        "السابق",
                        onTap: prev,
                        color: context.colors.primary,
                      ),
                    ),
                ],
              ),
            ],
          ).appPaddingAll(24),
        ],
      ),
    );
  }

  @override
  int get currentIndex => _currentIndex;

  @override
  int get pagesLength => items.length;

  @override
  void onFinish() {
    context.pushNamedAndRemoveUntil(Routes.signIn);
    sessionCubit.finishIntro();
  }
}
