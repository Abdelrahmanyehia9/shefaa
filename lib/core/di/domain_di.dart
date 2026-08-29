part of "get_it.dart";

Future<void> _registerDomainDependencies() async {
  sl.registerFactory<SignInEmailAndPasswordUseCase>(
    () => SignInEmailAndPasswordUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<SignUpUseCase>(() => SignUpUseCase(sl<AuthRepository>()));
  sl.registerFactory<SetupAuthListenersUseCase>(
    () => SetupAuthListenersUseCase(sl<UserSessionRepository>()),
  );
  sl.registerFactory<SignOutUseCase>(
    () => SignOutUseCase(sl<UserSessionRepository>()),
  );
  sl.registerFactory<FinishIntroUseCase>(
    () => FinishIntroUseCase(sl<UserSessionRepository>()),
  );
  sl.registerFactory<CompleteProfileUseCase>(
    () => CompleteProfileUseCase(sl<UserSessionRepository>()),
  );
  sl.registerFactory<GetSpecialitiesUseCase>(
    () => GetSpecialitiesUseCase(sl<SpecialityRepository>()),
  );
  sl.registerFactory<GetHomeNearbyClinicUseCase>(
    () => GetHomeNearbyClinicUseCase(sl<ClinicRepository>()),
  );
  sl.registerFactory<GetHomeTopRatedDoctorsUseCase>(
    () => GetHomeTopRatedDoctorsUseCase(sl<DoctorRepository>()),
  );

}
