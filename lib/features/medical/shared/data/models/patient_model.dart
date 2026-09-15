import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/features/medical/shared/domain/entity/patient_entity.dart';
import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/kinship_selector.dart';

class Patient {
  final UserModel user;

  final Kinship? kinship;

  const Patient({required this.user, required this.kinship});

  Map<String, dynamic> toJson() => {...user.toJson(), "kinship": kinship?.name};

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    user: UserModel.fromJson(json),
    kinship: enumFromJson(json['kinship'], Kinship.values),
  );

  PatientEntity toEntity() =>
      PatientEntity(user: user.toEntity(), kinship: kinship);
}
