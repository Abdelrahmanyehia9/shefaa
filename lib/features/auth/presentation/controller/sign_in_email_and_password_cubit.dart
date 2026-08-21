import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/auth/data/model/auth_request.dart';
import 'package:shefaa/features/auth/domain/usecase/sign_in_email_and_password_use_case.dart';

class SignInEmailAndPasswordCubit extends Cubit<BaseState<String>> {
  final SignInEmailAndPasswordUseCase _useCase;

  SignInEmailAndPasswordCubit(this._useCase) : super(const .initial());

  Future<void> signIn({required String email, required String password}) async {
    safeEmit(const .loading());
    final request = AuthRequest(email: email, password: password);
    final result = await _useCase.call(request);
    result.fold((e) => safeEmit(.failure(e)), (uId) => safeEmit(.success(uId)));
  }
}
