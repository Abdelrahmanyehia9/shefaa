import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/features/review/domain/entity/review_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/review_card.dart';

class ReviewsList extends StatelessWidget {
  final bool shrinkWrap;
  final List<ReviewEntity> reviews;
  const ReviewsList({
    super.key,
    this.shrinkWrap = true,
    this.reviews = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.zero,
      itemBuilder: (_, i) => ReviewCard(review: reviews[i]),
      separatorBuilder: (_, _) => const Divider().appPaddingVr(8),
      itemCount: reviews.length,
    );
  }
}
