import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/favorite_type.dart';
import 'package:shefaa/core/models/favorite.dart';
import 'package:shefaa/core/utils/fake_data.dart';

class ClinicEntity extends Equatable implements Favorite {
  @override
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
    required this.location,
  });

  @override
  List<Object?> get props => [id];

  static ClinicEntity get mock => ClinicEntity(
    id: FakeData.string(),
    name: FakeData.string(),
    rate: FakeData.decimal,
    image: FakeData.string(),
    waitingTimeInMin: FakeData.integer,
    location: FakeData.string(),
  );

  @override
  FavoriteType get type => FavoriteType.clinic;
}
