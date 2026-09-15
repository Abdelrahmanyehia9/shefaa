import 'package:equatable/equatable.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/kinship_selector.dart';

class PatientEntity extends Equatable {
  final UserEntity user;
  final Kinship? kinship;

  const PatientEntity({required this.user, required this.kinship});

  static PatientEntity get mock =>
      PatientEntity(user: UserEntity.mock, kinship: Kinship.other);

  @override
  List<Object?> get props => [user, kinship];
}
