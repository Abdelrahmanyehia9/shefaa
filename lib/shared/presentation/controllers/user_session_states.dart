import 'package:shefaa/shared/domain/entity/user_entity.dart';

sealed class UserSessionStates {
  const UserSessionStates();
}

final class UserSessionInitial extends UserSessionStates {}

final class UserSessionSignIn extends UserSessionStates {
  final UserEntity user;
  final bool skipLocation ;
  const UserSessionSignIn(this.user, {this.skipLocation =false});
}
final class UserSessionGuest extends UserSessionStates {
  const UserSessionGuest();
}

final class UserSessionFreshUser extends UserSessionStates {}

final class UserSessionSignOut extends UserSessionStates {}

final class UserSessionUpdateUser extends UserSessionStates {
  final UserEntity user;
  const UserSessionUpdateUser(this.user);
}
