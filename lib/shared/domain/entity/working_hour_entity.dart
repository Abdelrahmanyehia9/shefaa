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
  List<Object?> get props => [weekday, from, to];

  static WorkingHourEntity get mock => WorkingHourEntity(
    weekday: Weekday.friday,
    from: LocalTime.mock,
    to: LocalTime.mock,
  );
}

extension WorkingHoursFormatter on List<WorkingHourEntity> {
  String get formattedWorkingHour {
    if (isEmpty) return '';

    final sorted = [...this]
      ..sort((a, b) => a.weekday.index.compareTo(b.weekday.index));

    final groups = <List<WorkingHourEntity>>[];

    for (final item in sorted) {
      if (groups.isEmpty) {
        groups.add([item]);
        continue;
      }

      final currentGroup = groups.last;
      final last = currentGroup.last;

      final isConsecutive = item.weekday.index == last.weekday.index + 1;
      final isSameTime =
          item.from.hour == last.from.hour &&
              item.from.minute == last.from.minute &&
              item.to.hour == last.to.hour &&
              item.to.minute == last.to.minute;

      if (isConsecutive && isSameTime) {
        currentGroup.add(item);
      } else {
        groups.add([item]);
      }
    }

    return groups.map(_formatGroup).join('\n');
  }
  String _formatGroup(List<WorkingHourEntity> group) {
    final first = group.first;
    final last = group.last;

    final days = group.length == 1
        ? first.weekday.text
        : '${first.weekday.text} - ${last.weekday.text}';

    return '$days من ${first.from.formatted} إلى ${first.to.formatted}';
  }
}