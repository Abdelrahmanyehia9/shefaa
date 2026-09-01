import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/favorite_type.dart';
import 'package:shefaa/core/models/favorite.dart';
import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/shared/domain/entity/location_entity.dart';

class ClinicEntity extends Equatable implements Favorite {
  @override
  final int id;
  final String name;
  final double rate;
  final String? logo;
  final String? coverImage;
  final int waitingTimeInMin;
  final LocationEntity location;

  const ClinicEntity({
    required this.id,
    required this.name,
    required this.rate,
    required this.coverImage,
    required this.logo,
    required this.waitingTimeInMin,
    required this.location,
  });

  @override
  List<Object?> get props => [id];

  static ClinicEntity get mock => ClinicEntity(
    id: FakeData.integer,
    name: FakeData.string(),
    rate: FakeData.decimal,
    logo: FakeData.string(),
    waitingTimeInMin: FakeData.integer,
    coverImage: FakeData.string(),
    location: LocationEntity.mock,
  );

  @override
  FavoriteType get type => FavoriteType.clinic;
}
