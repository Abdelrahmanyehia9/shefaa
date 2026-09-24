part of '../doctor_screen.dart';

class _DoctorReviews extends StatelessWidget {
  final List<ReviewEntity> reviews;
  const _DoctorReviews({required this.reviews});
  static const _previewLimit = 3;
  static const _backendLimit = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "المراجعات", action: !(reviews.length >= _backendLimit) ? null : "عرض الكل", ),
       _reviewsList(items: reviews,),
      ],
    );
  }

  Widget _reviewsList({
    required List<ReviewEntity> items,
  }) {
    if (items.isEmpty) return ResultView.empty(message: "لايوجد مراجعات حتى الان",);
    return ReviewsList(reviews: items.take(_previewLimit).toList(),);
  }
}
