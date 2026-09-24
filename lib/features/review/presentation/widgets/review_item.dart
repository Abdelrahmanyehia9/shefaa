import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_rating_stars.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/review/presentation/controller/review_controller.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/media_input.dart';

class ReviewItem extends StatelessWidget {
  final Widget? header ;
  final String? question ;
  final bool canMediaUpload ;
  final ReviewController controller ;
  const ReviewItem({super.key, this.header, required this.controller, this.canMediaUpload = false, this.question});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: UISizes.h12,
        children: [
          Gap.small(),
          ?header ,
          if(question!=null)
          _buildChipQuestion(context),
          _buildOverAllRate(),
          _buildReviewComment(context),
          if(canMediaUpload)
          _buildUploadMediaContainer(),
      
      
      
      
      
        ],
      ),
    );
  }

  Widget _buildChipQuestion(BuildContext context)=> Row(
    spacing: UISizes.w8,
    children: [
      Expanded(child: Divider(color: context.colors.surfaceContainer,)),
      AppChip(
        titleStyle: context.textTheme.titleSmall,
        title: "كيف كانت استشارتك مع  $question ؟",
      ),
      Expanded(child: Divider(
        color: context.colors.surfaceContainer,
      ))
    ],
  );
  Widget _buildOverAllRate() => AppRatingStars(
    readOnly: false,
    spacing: UISizes.sp8,
    rating: controller.rate??0,
    onRatingChanged: (value) => controller.rate = value,
    size: UISizes.sp32,
  );

  Widget _buildReviewComment(BuildContext context) => AppTextField(
    headerText: "تعليق",
    controller: controller.comment,
    hintStyle: context.textTheme.bodyLarge?.copyWith(color: context.colors.surfaceContainer),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UISizes.r14),
        borderSide: BorderSide(
          color: context.colors.surfaceContainerLow,
        )
    ),
    hintText: "اكتب تعليق (اختيارى)",maxLines: 4,
  );
  Widget _buildUploadMediaContainer()=>const MediaInput();




}
