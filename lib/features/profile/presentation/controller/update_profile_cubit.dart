
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/profile/domain/usecase/update_profile_use_case.dart';
import 'package:shefaa/shared/data/models/user_model.dart';

class UpdateProfileCubit extends Cubit<BaseState<Unit>> {
  final UpdateProfileUseCase _useCase;
  UpdateProfileCubit(this._useCase) : super(const .initial());

  Future<void> update({
  required UserModel user
  }) async {

    safeEmit(const .loading());
    final result = await _useCase.call(user);
    result.fold((e) => safeEmit(.failure(e)), (s) => safeEmit(.success(s)));
  }
}
