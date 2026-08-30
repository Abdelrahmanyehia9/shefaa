import 'package:shefaa/shared/domain/entity/rate_entity.dart';

class Rate {
  final num value;
  final int count;

  const Rate({required this.value, required this.count});

  factory Rate.fromJson(Map<String, dynamic> json) =>
      Rate(value: json['value'], count: json['count']);

  RateEntity toEntity() => RateEntity(value: value.toDouble(), count: count);
}
