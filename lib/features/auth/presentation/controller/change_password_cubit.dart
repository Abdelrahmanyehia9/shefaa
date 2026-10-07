import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/auth/domain/usecase/change_password_use_case.dart';

class ChangePasswordCubit extends Cubit<BaseState<Unit>> {
  final ChangePasswordUseCase _useCase;

  ChangePasswordCubit(this._useCase) : super(const .initial());

  Future<void> changePassword({required String newPassword}) async {
    safeEmit(const .loading());
    final result = await _useCase.call(newPassword);
    result.fold((e) => safeEmit(.failure(e)), (s) => safeEmit(.success(s)));
  }
}
