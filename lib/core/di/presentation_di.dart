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
    () => CompleteProfileCubit(sl<UpdateProfileUseCase>()),
  ); sl.registerFactory<UpdateProfileCubit>(
    () => UpdateProfileCubit(sl<UpdateProfileUseCase>()),
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

  sl.registerFactoryParam<GetAllDoctorsCubit, DoctorRequest?, void>(
    (req, _) =>
        GetAllDoctorsCubit(sl<GetAllDoctorsUseCase>(), initialRequest: req),
  );
  sl.registerFactoryParam<GetAllClinicsCubit, ClinicRequest?, void>(
    (req, _) =>
        GetAllClinicsCubit(sl<GetAllClinicsUseCase>(), initialRequest: req),
  );
  sl.registerFactory<UserThemeCubit>(
    () => UserThemeCubit(
      getThemeUseCase: sl<GetThemeUseCase>(),
      changeThemeUseCase: sl<ChangeThemeUseCase>(),
    ),
  );
  sl.registerFactory<GetXDoctorCubit>(
    () => GetXDoctorCubit(sl<GetXDoctorUseCase>()),
  );
  sl.registerFactory<GetXClinicCubit>(
    () => GetXClinicCubit(sl<GetXClinicUseCase>()),
  );
  sl.registerFactory<GetDoctorAvailabilityCubit>(
    () => GetDoctorAvailabilityCubit(sl<GetDoctorAvailabilityUseCase>()),
  );
  sl.registerFactory<CreateBookingCubit>(
    () => CreateBookingCubit(sl<CreateBookingUseCase>()),
  );
  sl.registerFactory<GetBookingsUseCase>(
    () => GetBookingsUseCase(sl<BookingRepository>()),
  );
  sl.registerFactory<GetBookingsCubit>(
    () => GetBookingsCubit(sl<GetBookingsUseCase>()),
  );  sl.registerFactory<ChangeBookingDateCubit>(
    () => ChangeBookingDateCubit(sl<ChangeBookingDateUseCase>()),
  );  sl.registerFactory<CancelBookingCubit>(
    () => CancelBookingCubit(sl<CancelBookingUseCase>()),
  );
  sl.registerFactory<ReviewBookingCubit>(
    () => ReviewBookingCubit(sl<ReviewBookingUseCase>()),
  );  sl.registerFactory<PermissionCubit>(
    () => PermissionCubit(sl<PermissionHandler>()),
  );
  sl.registerFactory<GetNearbyClinicCubit>(
    () => GetNearbyClinicCubit(sl<GetNearbyClinicsUseCase>()),
  );

}
