part of "get_it.dart";

UserSessionCubit sessionCubit = sl<UserSessionCubit>();

Future<void> _registerPresentationDependencies() async {
  sl.registerFactory<SignInEmailAndPasswordCubit>(
    () => SignInEmailAndPasswordCubit(sl<SignInEmailAndPasswordUseCase>()),
  );
  sl.registerFactory<SignUpEmailAndPasswordCubit>(
    () => SignUpEmailAndPasswordCubit(sl<SignUpUseCase>()),
  );
  sl.registerLazySingleton<UserSessionCubit>(
    () => UserSessionCubit(
      sl<SetupAuthListenersUseCase>(),
      sl<SignOutUseCase>(),
      sl<FinishIntroUseCase>(),
    ),
  );
  sl.registerFactory<CompleteProfileCubit>(
    () => CompleteProfileCubit(sl<CompleteProfileUseCase>()),
  );
  sl.registerFactory<GetSpecialitiesCubit>(
    () => GetSpecialitiesCubit(sl<GetSpecialitiesUseCase>()),
  );
  sl.registerFactory<GetHomeNearbyClinicCubit>(
    () => GetHomeNearbyClinicCubit(sl<GetHomeNearbyClinicUseCase>()),
  );
  sl.registerFactory<GetHomeTopRatedDoctorsCubit>(
    () => GetHomeTopRatedDoctorsCubit(sl<GetHomeTopRatedDoctorsUseCase>()),
  );
  sl.registerLazySingleton<FavoriteCubit>(
    () => FavoriteCubit(
      getFavoritesUseCase: sl<GetFavoritesUseCase>(),
      toggleFavoriteUseCase: sl<ToggleFavoriteUseCase>(),
    ),
  );
  sl.registerFactory<GetAllClinicsCubit>(
    () => GetAllClinicsCubit(sl<GetAllClinicsUseCase>()),
  );
  sl.registerFactory<GetAllDoctorsCubit>(
    () => GetAllDoctorsCubit(sl<GetAllDoctorsUseCase>()),
  );
  sl.registerFactory<UserThemeCubit>(
    () => UserThemeCubit(
      getThemeUseCase: sl<GetThemeUseCase>(),
      changeThemeUseCase: sl<ChangeThemeUseCase>(),
    ),
  );
}
