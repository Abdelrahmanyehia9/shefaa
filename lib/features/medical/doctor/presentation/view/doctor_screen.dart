import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/presentation/view/book_doctor_screen.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_details_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_x_doctor_cubit.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_bio.dart';
import 'package:shefaa/features/review/domain/entity/review_entity.dart';
import 'package:shefaa/features/location/domain/entity/location_entity.dart';
import 'package:shefaa/shared/domain/entity/working_hour_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/widgets/doctor_preview_card.dart';
import 'package:shefaa/features/explore/presentation/view/widgets/map_view.dart';
import 'package:shefaa/shared/presentation/mixin/scroll_visibility.dart';
import 'package:shefaa/shared/presentation/view/layout/reviews_list.dart';
import 'package:shefaa/shared/presentation/view/layout/sticky_bottom_layout.dart';
import 'package:shefaa/features/favorite/presentation/view/widgets/app_favorite_button.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_share_button.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/default_sticky_button.dart';

part 'widgets/doctor_working_hours.dart';

part 'widgets/doctor_location.dart';

part 'widgets/doctor_reviews.dart';

part 'widgets/doctor_bio.dart';

class DoctorScreen extends StatefulWidget {
  final DoctorEntity doctor;

  const DoctorScreen({super.key, required this.doctor});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with ScrollTitleVisibilityMixin {
  @override
  double get titleThreshold => UISizes.h80;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      topPadding: false,
      body: StickyBottomLayout(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            title: title("د/${widget.doctor.name}"),
            backgroundColor: context.scaffoldBackgroundColor,
            centerTitle: true,
            actions: [
              AppFavoriteButton(isOutlined: true, favorite: widget.doctor),
              Gap.small(),
              const AppShareButton(),
            ],
          ),
        ],
        content: Column(
          spacing: UISizes.h12,
          children: [
            BaseBlocConsumer<GetXDoctorCubit, DoctorDetailsEntity>(
              shimmerLoading: false,
              successBuilder: (d) => DoctorPreviewCard(
                doctor: d,
                clinic: d.clinic,
                bookingOptions: d.bookingOptions,
              ),
              loadingBuilder: () => DoctorPreviewCard(doctor: widget.doctor),
            ),
            BaseBlocConsumer<GetXDoctorCubit, DoctorDetailsEntity>(
              successBuilder: _builder,
              loadingBuilder: () => _builder(DoctorDetailsEntity.mock),
            ),
          ],
        ).paddingAll,
        sticky: BaseBlocConsumer<GetXDoctorCubit, DoctorDetailsEntity>(
          successBuilder: (d) => DefaultStickyFooter(
            title: "حجز موعد",
            onTap: () => context.pushNamed(
              Routes.bookDoctor,
              arguments: BookDoctorScreenArgs(
                doctor: d,
                options: d.bookingOptions,
                clinic: d.clinic,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _builder(DoctorDetailsEntity doctor) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: UISizes.h12,
    children: [
      if (doctor.bio != null) ...[const Divider(), _DoctorBio(bio: doctor.bio)],
      _DoctorWorkingHours(workingHours: doctor.workingHour),
      _DoctorLocation(doctor.clinic.location),
      _DoctorReviews(reviews: doctor.reviews),
    ],
  );
}
