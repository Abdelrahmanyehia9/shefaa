import 'package:shefaa/core/enum/weekday.dart';
import 'package:shefaa/core/models/local_time.dart';

class WorkingHour {
  final Weekday weekday;
  final LocalTime from;
  final LocalTime to;

  const WorkingHour({
    required this.weekday,
    required this.from,
    required this.to,
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json) {
    return WorkingHour(
      weekday: Weekday.values.byName(json['weekday'] as String),
      from: LocalTime.fromJson(json['from'] as Map<String, dynamic>),
      to: LocalTime.fromJson(json['to'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'weekday': weekday.name, 'from': from.toJson(), 'to': to.toJson()};
  }
}
