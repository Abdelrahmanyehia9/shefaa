import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';
import 'package:shefaa/shared/domain/usecase/finish_intro_use_case.dart';
import 'package:shefaa/shared/domain/usecase/setup_auth_listeners_use_case.dart';
import 'package:shefaa/shared/domain/usecase/sign_out_use_case.dart';
import 'package:shefaa/shared/presentation/controllers/user_session_states.dart';

class UserSessionCubit extends Cubit<UserSessionStates> {
  final SetupAuthListenersUseCase _listenersUseCase;
  final FinishIntroUseCase _finishIntroUseCase;
  final SignOutUseCase _signOutUseCase;
  UserEntity? _user;

  UserSessionCubit(
    this._listenersUseCase,
    this._signOutUseCase,
    this._finishIntroUseCase,
  ) : super(UserSessionInitial());

  void init() => _listenersUseCase.call(
    onSignedIn: (user) {
      _user = user;
      safeEmit(UserSessionSignIn(user));
    },
    onSignedOut: () {
      _user = null;
      safeEmit(UserSessionSignOut());
    },
    onUserUpdated: (user) {
      _user = user;
      safeEmit(UserSessionUpdateUser(user));
    },
    onFirstTime: () => safeEmit(UserSessionFreshUser()),
  );

  Future<void> finishIntro() => _finishIntroUseCase.call();

  Future<void> signOut() => _signOutUseCase.call();

  bool get isGuest => _user == null;
}
