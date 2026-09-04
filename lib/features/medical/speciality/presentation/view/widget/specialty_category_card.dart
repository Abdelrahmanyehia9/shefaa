import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/category_svg.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_chip.dart';

class SpecialtyCategoryCard extends StatelessWidget {
  final bool showLabel;
  final double? height, width;
  final int? maxLine;
  final Axis axis;
  final SpecialityEntity speciality;

  const SpecialtyCategoryCard({
    super.key,
    this.height,
    this.width,
    this.maxLine = 2,
    this.showLabel = true,
    this.axis = Axis.vertical,
    required this.speciality,
  });

  static Size cardSize = Size(UISizes.sp72, UISizes.sp40);

  Widget _buildIconChip(
    BuildContext context,
    Color color,
    double width,
    double height,
  ) {
    return CircleChip(
      child: CategorySVG(url: speciality.icon, color: color, size: height),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? cardSize.height;
    final width = this.width ?? cardSize.width;
    final color = context.colors.primary;

    if (axis.isVertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconChip(context, color, height, height),
          if (showLabel)
            SizedBox(
              width: width,
              child: AppText(
                speciality.title,
                maxLines: maxLine,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelMedium,
              ),
            ),
        ],
      );
    }

    return Row(
      spacing: UISizes.w8,
      children: [
        _buildIconChip(context, color, height, height),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                speciality.title,
                style: context.textTheme.labelMedium,
                height: 0,
              ),
              AppText(
                "${speciality.numOfDoctor} طبيب متوفر  ",
                style: context.textTheme.bodyMedium,
                color: context.colors.surfaceContainer,
              ),
            ],
          ),
        ),
        Icon(AppIcons.arrowForward, size: UISizes.sp18, color: color),
      ],
    );
  }
}
