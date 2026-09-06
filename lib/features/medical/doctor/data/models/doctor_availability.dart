import 'package:shefaa/core/enum/weekday.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/core/models/local_time.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_availability_entity.dart';

class DoctorAvailability {
  final DateTime date;
  final Weekday weekday;
  final List<AvailabilitySlot> availability;

  const DoctorAvailability({
    required this.date,
    required this.weekday,
    required this.availability,
  });

  factory DoctorAvailability.fromJson(Map<String, dynamic> json) =>
      DoctorAvailability(
        date: DateTime.parse(json['date'] as String),
        weekday: enumFromJson(json['weekday'], Weekday.values)!,
        availability: (json['availability'] as List<dynamic>)
            .map((e) => AvailabilitySlot.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'weekday': weekday.name,
    'availability': availability.map((e) => e.toJson()).toList(),
  };

  DoctorAvailabilityEntity toEntity() => DoctorAvailabilityEntity(
    date: date,
    weekday: weekday,
    availability: availability.map((e) => e.toEntity()).toList(),
  );
}

class AvailabilitySlot {
  final LocalTime time;
  final bool isBooked;

  const AvailabilitySlot({required this.time, required this.isBooked});

  factory AvailabilitySlot.fromJson(Map<String, dynamic> json) {
    return AvailabilitySlot(
      time: LocalTime.fromJson(json['time'] as Map<String, dynamic>),
      isBooked: json['isBooked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'time': time.toJson(), 'isBooked': isBooked};
  }

  AvailabilitySlotEntity toEntity() =>
      AvailabilitySlotEntity(time: time, isBooked: isBooked);
}
