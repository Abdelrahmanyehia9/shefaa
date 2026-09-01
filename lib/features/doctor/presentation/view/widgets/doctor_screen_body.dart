part of "../doctor_screen.dart";

class DoctorScreenBody extends StatefulWidget {
  final DoctorDetailsEntity doctor;

  const DoctorScreenBody({super.key, required this.doctor});

  @override
  State<DoctorScreenBody> createState() => _DoctorScreenBodyState();
}

class _DoctorScreenBodyState extends State<DoctorScreenBody>
    with ScrollTitleVisibilityMixin {
  @override
  double get titleThreshold => UISizes.h80;

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;
    return StickyBottomLayout(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          title: title("د/خالد احمد"),
          backgroundColor: context.scaffoldBackgroundColor,
          centerTitle: true,
          actions: [
            const AppFavoriteButton(isOutlined: true),
            Gap.small(),
            const AppShareButton(),
          ],
        ),
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: UISizes.h12,
        children: [
          DoctorHeader(
            doctor: doctor,
            clinic: doctor.clinic,
            bookingOptions: doctor.bookingOptions,
          ),
          if (doctor.bio != null) ...[const Divider(), _DoctorBio(doctor.bio!)],
          _DoctorWorkingHours(workingHours: doctor.workingHour),
          _DoctorLocation(doctor.clinic.location),
          _DoctorReviews(reviews: doctor.reviews),
        ],
      ).paddingAll,
      sticky: DefaultStickyFooter(
        title: "حجز موعد",
        onTap: () => context.pushNamed(Routes.bookDoctor),
      ),
    );
  }
}
