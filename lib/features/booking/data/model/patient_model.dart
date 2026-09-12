import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/presentation/view/widgets/selector/kinship_selector.dart';

class Patient {
  final UserModel user ;
  final Kinship? kinship;

  const Patient({
    required this.user,
    required this.kinship,
  });

  Map<String , dynamic> toJson()=>{
   ...user.toJson(),
    "kinship":kinship?.name
  };
}
