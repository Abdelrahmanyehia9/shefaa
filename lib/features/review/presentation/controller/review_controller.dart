import 'package:flutter/material.dart';
import 'package:shefaa/features/review/data/models/review_request.dart';

class ReviewController {
  double? rate;
  final TextEditingController comment;

  ReviewController({
    this.rate,
    TextEditingController? comment,
  }) : comment = comment ?? TextEditingController();

  void dispose() => comment.dispose();

  ReviewRequest toRequest() =>
      ReviewRequest(
          rating: rate, comment: comment.text.trim(),
          );

}