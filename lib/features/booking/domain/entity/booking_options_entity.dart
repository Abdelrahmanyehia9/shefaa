import 'package:equatable/equatable.dart';
import 'package:shefaa/core/utils/fake_data.dart';

class BookingOptionsEntity extends Equatable {
  final num consultFees;

  final int consultTime;

  final int breakTime;

  const BookingOptionsEntity({
    required this.consultFees,
    required this.consultTime,
    required this.breakTime,
  });

  @override
  List<Object?> get props => [consultTime, consultFees, breakTime];

  int get totalPatientTime => consultTime + breakTime;

  static BookingOptionsEntity get mock => const BookingOptionsEntity(
    consultFees: FakeData.integer,
    consultTime: FakeData.integer,
    breakTime: FakeData.integer,
  );
}
