import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/profile/domain/usecase/complete_profile_use_case.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';
import 'package:shefaa/shared/data/models/user_model.dart';

class CompleteProfileCubit extends Cubit<BaseState<Unit>> {
  final CompleteProfileUseCase _useCase;
  CompleteProfileCubit(this._useCase) : super(const .initial());

  Future<void> update({
    required String uid,
    String? firstname,
    String? lastname,
    PhoneNumber? phone,
    DateTime? dop,
    required Gender gender,
  }) async {
    UserModel u = UserModel(
      id: uid,
      firstname: firstname,
      lastName: lastname,
      dob: dop,
      gender: gender,
      phone: phone,
    );
    safeEmit(const .loading());
    final result = await _useCase.call(u);
    result.fold((e) => safeEmit(.failure(e)), (s) => safeEmit(.success(s)));
  }
}
