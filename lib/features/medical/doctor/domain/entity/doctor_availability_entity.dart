import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/weekday.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/models/local_time.dart';
import 'package:shefaa/core/utils/fake_data.dart';



class DoctorAvailabilityEntity extends Equatable {
  final DateTime date;
  final Weekday weekday;
  final List<AvailabilitySlotEntity> availability;

  const DoctorAvailabilityEntity({
    required this.date,
    required this.weekday,
    required this.availability,
  });

  @override
  List<Object?> get props => [date, weekday, availability];

  static DoctorAvailabilityEntity get mock => DoctorAvailabilityEntity(
    date: FakeData.dateTime,
    weekday: Weekday.friday,
    availability: AvailabilitySlotEntity.mock.fakeList(4),
  );

  bool get isFullBooked => availability.any((e)=>e.isBooked) ;

}



extension DoctorAvailabilityEXT on List<DoctorAvailabilityEntity>{
  List<(Weekday, DateTime)> get days => map((x)=>(x.weekday, x.date)).toList();
}

class AvailabilitySlotEntity extends Equatable{
  final LocalTime time;
  final bool isBooked;

  const AvailabilitySlotEntity({required this.time, required this.isBooked});

  @override
  // TODO: implement props
  List<Object?> get props => [time, isBooked];
  static AvailabilitySlotEntity get mock => AvailabilitySlotEntity(
      time: LocalTime.mock,
      isBooked: FakeData.boolean
  );


}
