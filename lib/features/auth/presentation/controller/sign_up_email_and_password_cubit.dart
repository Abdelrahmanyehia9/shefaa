import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/auth/data/model/auth_request.dart';
import 'package:shefaa/features/auth/domain/usecase/sign_up_use_case.dart';

class SignUpEmailAndPasswordCubit extends Cubit<BaseState<String>> {
  final SignUpUseCase _useCase;
  SignUpEmailAndPasswordCubit(this._useCase) : super(const .initial());

  Future<void> signup({
    String? fName,
    String? lName,
    required String email,
    required String password,
  }) async {
    safeEmit(const .loading());
    final request = AuthRequest(
      email: email,
      password: password,
      fName: fName,
      lName: lName,
    );
    final result = await _useCase.call(request);
    result.fold((e) => safeEmit(.failure(e)), (uId) => safeEmit(.success(uId)));
  }
}
