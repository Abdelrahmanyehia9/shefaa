import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/shared/presentation/view/widgets/review_card.dart';

class ReviewsList extends StatelessWidget {
  final bool shrinkWrap;
  const ReviewsList({super.key, this.shrinkWrap = true});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.zero,
      itemBuilder: (_, i) => ReviewCard(hasMedia: i == 1),
      separatorBuilder: (_, _) => const Divider().appPaddingVr(8),
      itemCount: 3,
    );
  }
}
