import 'package:equatable/equatable.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';

class ReviewEntity extends Equatable {
  final UserEntity reviewer;
  final DateTime createdAt;
  final double rate;
  final String? comment;

  const ReviewEntity({
    required this.reviewer,
    required this.createdAt,
    required this.rate,
    required this.comment,
  });

  @override
  List<Object?> get props => [reviewer, createdAt, rate, comment];

  static ReviewEntity get mock => ReviewEntity(
    reviewer: UserEntity.mock,
    createdAt: FakeData.dateTime,
    rate: FakeData.decimal,
    comment: FakeData.string(22),
  );
}
