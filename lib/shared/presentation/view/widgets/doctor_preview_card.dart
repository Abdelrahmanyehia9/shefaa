import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_rating_stars.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_highlight.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_options_entity.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/shared/domain/entity/rate_entity.dart';

class DoctorPreviewCard extends StatelessWidget {
  final DoctorEntity doctor;
  final ClinicEntity? clinic;
  final BookingOptionsEntity? bookingOptions;
  const DoctorPreviewCard({
    super.key,
    required this.doctor,
    this.bookingOptions,
    this.clinic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: UISizes.h8,
      children: [
        _DoctorPreviewCardHeader(doctor: doctor, clinic: clinic,),
        if (bookingOptions != null) ...[
          const Divider(),
          _DoctorStates(options: bookingOptions!),
        ],
      ],
    );
  }
}

class _DoctorPreviewCardHeader extends StatelessWidget {
  final DoctorEntity doctor;
  final ClinicEntity? clinic;
  const _DoctorPreviewCardHeader({required this.doctor, this.clinic});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w8,
      children: [
        Hero(
            tag: ValueKey(doctor),
            child: UserAvatar(size: UISizes.sp72, image: doctor.image)),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DoctorDetails(doctor: doctor, clinic: clinic),
              _DoctorRating(doctor.rate),
            ],
          ),
        ),
      ],
    );
  }
}


class _DoctorDetails extends StatelessWidget {
  final DoctorEntity doctor;

  final ClinicEntity? clinic;

  const _DoctorDetails({this.clinic, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "دكتور ${doctor.name}",
                style: context.textTheme.labelLarge,
              ),
              AppText(doctor.doctorTitle, style: context.textTheme.bodySmall),
            ],
          ),
        ),
        if (clinic != null)
          Flexible(
            flex: 2,
            child: AppClick(
              onTap: ()=>context.pushNamed(Routes.clinic, arguments: clinic),
              child: AppIconText(
                icon: AppIcons.clinic,
                expandedText: true,
                iconSize: UISizes.sp16,
                textStyle: context.textTheme.titleSmall,
                color: context.colors.primary,
                text: clinic!.name,
              ),
            ),
          ),
      ],
    );
  }
}
class _DoctorRating extends StatelessWidget {
  final RateEntity rating;
  const _DoctorRating(this.rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w4,
      children: [
        AppRatingStars(rating: rating.value),
        Expanded(
          child: AppTextHighLight(
            "(التقييم من *${rating.count}* مراجعة)",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.surfaceContainer,
            ),
            highlighterStyle: context.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
class _DoctorStates extends StatelessWidget {
  final BookingOptionsEntity options;
  const _DoctorStates({required this.options});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w8,
      children: [
        Expanded(
          child: _item(
            context,
            text: "وقت الانتظار ${options.totalPatientTime} د",
            icon: AppIcons.time,
          ),
        ),
        _divider(context),
        Expanded(
          child: _item(
            context,
            text: "الكشف ${options.consultFees} جنيه",
            icon: AppIcons.wallet,
          ),
        ),
      ],
    );
  }

  Widget _divider(BuildContext context) => Container(
    height: UISizes.sp32,
    width: UISizes.sp1,
    color: context.colors.surfaceContainerLowest,
  );

  Widget _item(
    BuildContext context, {
    required String text,
    required IconData icon,
  }) => AppIconText(
    text: text,
    icon: icon,
    mainAxisAlignment: MainAxisAlignment.center,
    iconColor: context.colors.primary,
    textStyle: context.textTheme.labelMedium,
    iconSize: UISizes.sp18,
  );
}
