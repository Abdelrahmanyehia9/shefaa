import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        spacing: UISizes.h10,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //icon
          AppChip(
            shape: BoxShape.circle,
            paddingVr: UISizes.sp24,
            paddingHr: UISizes.sp24,
            monochromatic: true,
            child: Icon(
              AppIcons.locationAcess,
              size: UISizes.sp84,
              color: context.colors.primary,
            ),
          ),
          4.spaceVr,
          _buildTitleAndSubTitle(),
          4.spaceVr,

          ///actions
          AppButton.filled("السماح بالوصول"),
          AppButton.filled(
            "أدخل الموقع يدويا",
            backgroundColor: Colors.transparent,
            style: context.textTheme.labelLarge,
            textColor: context.colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAndSubTitle() => Builder(
    builder: (context) => Column(
      children: [
        AppText(
          textAlign: TextAlign.center,
          "أين موقعك؟",
          style: context.textTheme.displaySmall,
        ),
        AppText(
          textAlign: TextAlign.center,
          "نحتاج إلى معرفة موقعك لنقترح عليك الخدمات القريبة.",
          style: context.textTheme.bodyLarge,
          color: context.colors.surfaceContainer,
        ),
      ],
    ),
  );
}
