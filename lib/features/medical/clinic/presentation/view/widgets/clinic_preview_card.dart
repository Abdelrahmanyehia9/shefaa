import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';

class ClinicPreviewCard extends StatelessWidget {
  final ClinicEntity clinic;
  const ClinicPreviewCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w16,
      children: [
        UserAvatar(
          size: UISizes.sp64,
          image:
            clinic.logo
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(clinic.name, style: context.textTheme.labelMedium),
              if(!clinic.location.name.isNullOrEmpty)
              AppIconText(
                expandedText: true,
                icon: AppIcons.bookingLocation,
                iconSize: UISizes.sp16,
                color: context.colors.surfaceContainer,
                textStyle: context.textTheme.labelSmall,
                text: clinic.location.name
              ),
            ],
          ),
        ),
      ],
    );
  }
}
