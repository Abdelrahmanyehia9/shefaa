import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class SpecialtyCategoryCard extends StatelessWidget {
  final bool showLabel;
  final double? height, width;
  final int? maxLine ;

  const SpecialtyCategoryCard({
    super.key,
    this.height,
    this.width,
    this.maxLine = 2,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? UISizes.sp40 ;
    final width = this.width ?? UISizes.sp72 ;
    final color = context.colors.primary ;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppChip(
          paddingHr: 14,
          paddingVr: 14,
          shape: BoxShape.circle,
          color: color,
          monochromatic: true,
          child: SvgPicture.network(
            width: width,
            height: height,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            "https://bdpceetislgzwpsqyfws.supabase.co/storage/v1/object/public/app_data/specialist/Union.svg",
          ),
        ),
        if (showLabel)
          SizedBox(
            width: width,
            child: AppText(
              "قلب",
              maxLines: maxLine,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium
            ),
          ),
      ],
    );
  }
}
