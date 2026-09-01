import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/weekday.dart';
import 'package:shefaa/core/models/local_time.dart';

class WorkingHourEntity extends Equatable {
  final Weekday weekday;
  final LocalTime from;
  final LocalTime to;

  const WorkingHourEntity({
    required this.weekday,
    required this.from,
    required this.to,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [weekday, from, to];

  static WorkingHourEntity get mock => WorkingHourEntity(
    weekday: Weekday.friday,
    from: LocalTime.mock,
    to: LocalTime.mock,
  );
}
