import 'package:shefaa/core/utils/fake_data.dart';

class LocalTime {
  final int hour;
  final int minute;

  const LocalTime({required this.hour, required this.minute});

  factory LocalTime.fromJson(Map<String, dynamic> json) {
    return LocalTime(hour: json['hour'] as int, minute: json['minute'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'hour': hour, 'minute': minute};
  }

  static LocalTime get mock =>
      const LocalTime(hour: FakeData.integer, minute: FakeData.integer);

  String get formatted {
    final period = hour >= 12 ? 'م' : 'ص';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    final displayMinute = minute.toString().padLeft(2, '0');

    return '$displayHour:$displayMinute $period';
  }
}
