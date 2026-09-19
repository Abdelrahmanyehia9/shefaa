import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_rating_stars.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_doctor_info.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/media_input.dart';

class ReviewBookingScreen extends StatefulWidget {
  final BookingEntity booking;

  const ReviewBookingScreen({super.key, required this.booking});

  @override
  State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends State<ReviewBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const AppText("تقييم الاستشارة")),
      body: SingleChildScrollView(
        child: Column(
          spacing: UISizes.h12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingDoctorInfo(doctor: widget.booking.doctor),
            _buildChipQuestion(),
            _buildOverAllRate(),
            _buildReviewComment(),
            _buildUploadMediaContainer(),
            Gap.medium(),
            AppButton.filled("التالى"),
            AppButton.outlined("السابق", color: context.colors.primary,)
          ],
        ),
      ),
    );
  }

  Widget _buildChipQuestion()=> Row(
      spacing: UISizes.w8,
      children: [
        Expanded(child: Divider(color: context.colors.surfaceContainer,)),
        AppChip(
          titleStyle: context.textTheme.titleSmall,
          title: "كيف كانت استشارتك مع د / ${widget.booking.doctor.name} ؟",
        ),
        Expanded(child: Divider(
          color: context.colors.surfaceContainer,
        ))
      ],
    );
  Widget _buildOverAllRate() => AppRatingStars(
    readOnly: false,
    spacing: UISizes.sp20,
    title: "التقييم الاجمالى",
    onRatingChanged: (value) {
    },
    size: UISizes.sp32,
  );
  Widget _buildReviewComment() => const Column(
      children: [
        SectionHeader(title: "تعليق"),
       AppTextField(
         hintText: "اكتب تعليق (اختيارى)",maxLines: 4,
       )
      ],
    );
  Widget _buildUploadMediaContainer()=>const MediaInput();
}
