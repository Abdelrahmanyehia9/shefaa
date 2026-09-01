import 'package:shefaa/features/booking/domain/entity/booking_options_entity.dart';

class BookingOptions {
  final num consultFees;

  final int consultTime;

  final int breakTime;

  const BookingOptions({
    required this.consultFees,
    required this.consultTime,
    required this.breakTime,
  });

  factory BookingOptions.fromJson(Map<String, dynamic> json) => BookingOptions(
    consultFees: json["consultation_fee"],
    consultTime: json['consultation_time_in_min'] as int,
    breakTime: json['break_in_min'] as int,
  );

  BookingOptionsEntity toEntity() => BookingOptionsEntity(
    consultFees: consultFees,
    consultTime: consultTime,
    breakTime: breakTime,
  );
}
