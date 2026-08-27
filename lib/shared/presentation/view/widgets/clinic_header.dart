import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class ClinicHeader extends StatelessWidget {
  const ClinicHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w16,
      children: [
        UserAvatar(
          size: UISizes.sp64,
          image:
              "https://nafezly-production.fra1.cdn.digitaloceanspaces.com/uploads/portfolios/29246_633eff9fd1484-1665073055.jpg",
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText("عيادة الحياه", style: context.textTheme.labelMedium),
              AppIconText(
                icon: AppIcons.bookingLocation,
                iconSize: UISizes.sp16,
                textStyle: context.textTheme.labelSmall,
                text: "324 شارع الحياه حمص , سوريا",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
