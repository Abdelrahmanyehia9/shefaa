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
  sl.registerFactory<GetFavoritesUseCase>(
    () => GetFavoritesUseCase(sl<FavoriteRepository>()),
  );
  sl.registerFactory<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(sl<FavoriteRepository>()),
  );
  sl.registerFactory<GetAllClinicsUseCase>(
    () => GetAllClinicsUseCase(sl<ClinicRepository>()),
  );
  sl.registerFactory<GetAllDoctorsUseCase>(
    () => GetAllDoctorsUseCase(sl<DoctorRepository>()),
  );
  sl.registerFactory<GetThemeUseCase>(
    () => GetThemeUseCase(sl<UserSessionRepository>()),
  );
  sl.registerFactory<ChangeThemeUseCase>(
    () => ChangeThemeUseCase(sl<UserSessionRepository>()),
  );
  sl.registerFactory<GetXDoctorUseCase>(
    () => GetXDoctorUseCase(sl<DoctorRepository>()),
  );
}
