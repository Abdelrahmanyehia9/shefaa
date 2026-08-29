import 'package:equatable/equatable.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/shared/domain/entity/location_entity.dart';

class ClinicEntity extends Equatable {
  final String id;
  final String name;
  final double rate;
  final String? image;
  final int waitingTimeInMin;
  final String location;

  const ClinicEntity({
    required this.id,
    required this.name,
    required this.rate,
    required this.image,
    required this.waitingTimeInMin,
    required this.location
  });

  @override
  List<Object?> get props => [id];


  static ClinicEntity get mock =>
      ClinicEntity(
          id: FakeData.string(),
          name: FakeData.string(),
          rate: FakeData.decimal,
          image: FakeData.string(),
          waitingTimeInMin: FakeData.integer,
          location: FakeData.string()
      );
}
