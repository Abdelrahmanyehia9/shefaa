part of '../doctor_screen.dart';

class _DoctorReviews extends StatelessWidget {
  const _DoctorReviews();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h12,
      children: const [
        SectionHeader(title: "المراجعات", action: "عرض الكل"),
        ReviewsList(),
      ],
    );
  }
}
