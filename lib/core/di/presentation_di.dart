part of "get_it.dart";

Future<void> _registerPresentationDependencies() async {
  sl.registerFactory<SignInEmailAndPasswordCubit>(
    () => SignInEmailAndPasswordCubit(sl<SignInEmailAndPasswordUseCase>()),
  );
}
