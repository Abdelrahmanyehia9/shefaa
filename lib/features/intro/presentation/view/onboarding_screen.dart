import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_slider_dots.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/intro/data/models/onboarding.dart';
import 'package:shefaa/features/intro/presentation/view/widgets/onboarding_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();
  final items = Onboarding.data;
  int _currentIndex = 0;
  bool get _isLast => _currentIndex == items.length - 1;
  bool get _isFirst => _currentIndex == 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      body: Column(
        children: [
          Visibility(
            visible: !_isLast,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: AppButton.text(
              'تخطي',
              onTap: _onFinish,
              style: context.textTheme.bodyLarge,
              textColor: context.colors.surfaceContainerHigh,
              margin: EdgeInsets.all(UISizes.sp24),
              align: AlignmentGeometry.topEnd,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              itemCount: items.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (_, i) => AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                 final isVisible = _pageController.isFullVisible(i);
                  return OnboardingItem(item: items[i], isFullVisible: isVisible,).paddingHr;
                },
              ),            ),
          ),
          Column(
            spacing: UISizes.sp24,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppSliderDots(total: items.length, currentIndex: _currentIndex,
              width: (_)=>UISizes.sp20,
              margin: UISizes.w2,),
              Row(
                spacing: UISizes.w8,
                children: [
                  Expanded(child: AppButton.filled("التالى" , onTap: _next,)),
                  if(!_isFirst)
                  Expanded(child: AppButton.outlined("السابق",
                    onTap: _prev,
                    color: context.colors.primary,)
                  ),

                ],
              )
            ],
          ).appPaddingAll(24),
        ],
      ),
    );
  }

  void _next() {
    if (_isLast) {
      return _onFinish();
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  void _prev() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  void _onFinish() {
    context.pushNamedAndRemoveUntil(Routes.signIn);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
