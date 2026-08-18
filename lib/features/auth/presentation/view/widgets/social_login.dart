import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_svg.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_assets.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.sp20,
      children: [
        const _Divider(),
        Row(
          spacing: UISizes.w12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialIcon(AppAssets.faceBookSvg, onTap: () {}),
            const _SocialIcon(AppAssets.googleSvg),
            const _SocialIcon(AppAssets.appleSvg),
          ],
        ),
      ],
    ).appPaddingVr(32);
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .8,
      child: Row(
        spacing: UISizes.w12,
        children: [
          const Expanded(child: Divider()),
          AppText(
            "أو تابع باستخدام",
            style: context.textTheme.bodyMedium,
            color: context.colors.surfaceContainer,
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String svg;
  const _SocialIcon(this.svg, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleIconButton.outLine(
      null,
      backgroundColor: context.scaffoldBackgroundColor,
      onTap: onTap,
      context: context,
      padding: UISizes.sp14,
      customIcon: AppSvg.asset(svg, width: UISizes.sp28),
    );
  }
}
