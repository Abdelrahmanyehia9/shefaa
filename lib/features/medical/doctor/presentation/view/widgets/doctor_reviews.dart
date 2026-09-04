part of '../doctor_screen.dart';

class _DoctorReviews extends StatelessWidget {
  final List<ReviewEntity> reviews;
  const _DoctorReviews({required this.reviews});

  @override
  Widget build(BuildContext context) {
    bool isEmpty = reviews.isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "المراجعات",
          action: !isEmpty ? null :  "عرض الكل",
        ),
        if (isEmpty)
          const AppText("لايوجد مراجعات حتى الان")
        else
          ReviewsList(reviews: reviews),
      ],
    );
  }
}
