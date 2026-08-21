part of "get_it.dart";

Future<void> _registerDomainDependencies() async {
  sl.registerFactory<SignInEmailAndPasswordUseCase>(
    () => SignInEmailAndPasswordUseCase(sl<AuthRepository>()),
  );
}
