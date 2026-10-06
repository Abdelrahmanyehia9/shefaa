import 'package:shefaa/core/utils/fake_data.dart';
import 'package:shefaa/features/location/domain/entity/location_entity.dart';

class UserLocationEntity extends LocationEntity {
  final int id;
  final bool isSelected;
  final String government;
  final String area;
  final String build;
  final String flatNo;
  final String floor;
  final String street ;

  const UserLocationEntity({
    required this.id,
    required super.name,
    required super.lat,
    required super.long,
    required this.government,
    required this.area,
    required this.build,
    required this.flatNo,
    required this.street,
    required this.floor,
    this.isSelected = false,
  });

  @override
  List<Object?> get props =>
      [
        ...super.props,
        id,
        isSelected,
        government,
        area,
        build,
        flatNo,
        floor,
      ];

  UserLocationEntity copyWith({bool? isSelected}) =>
      UserLocationEntity(
        id: id,
        name: name,
        lat: lat,
        long: long,
        street: street,
        government: government,
        area: area,
        build: build,
        flatNo: flatNo,
        floor: floor,
        isSelected: isSelected ?? this.isSelected,
      );

  static UserLocationEntity get mock =>
      UserLocationEntity(id: FakeData.integer,
          name: FakeData.string(2),
          lat: FakeData.decimal,
          long: FakeData.decimal,
          street: FakeData.string(6),
          government: FakeData.string(),
          area: FakeData.string(2),
          build: FakeData.string(),
          flatNo: FakeData.string(),
          floor: FakeData.string());
}