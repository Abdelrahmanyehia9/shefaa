import 'package:shefaa/features/review/domain/entity/review_entity.dart';
import 'package:shefaa/shared/data/models/user_model.dart';

class Review {
  final UserModel reviewer;
  final DateTime createdAt;
  final double rate;
  final String? comment;

  Review({
    required this.reviewer,
    required this.createdAt,
    required this.rate,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewer: UserModel.fromJson(json['reviewer']),
      createdAt: DateTime.parse(json['created_at']),
      rate: (json['rate'] as num).toDouble(),
      comment: json['comment'],
    );
  }

  ReviewEntity toEntity() => ReviewEntity(
    reviewer: reviewer.toEntity(),
    createdAt: createdAt,
    rate: rate,
    comment: comment,
  );
}
