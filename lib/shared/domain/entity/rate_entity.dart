import 'package:shefaa/core/utils/fake_data.dart';

class RateEntity {
  final double value;
  final int count;

  const RateEntity({required this.value, required this.count});

  static RateEntity get mock =>
      const RateEntity(value: FakeData.decimal, count: FakeData.integer);
}
