part of "get_it.dart";

Future<void> _registerDataDependencies() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<AuthService>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton<UserSessionRemoteDataSource>(
    () => UserSessionRemoteDataSource(sl<AuthService>(), sl<SupabaseService>()),
  );
  sl.registerLazySingleton<UserSessionLocalDataSource>(
    () => UserSessionLocalDataSource(sl<KeyValueStorage>()),
  );
  sl.registerLazySingleton<UserSessionRepository>(
    () => UserSessionRepositoryImpl(
      remoteDataSource: sl<UserSessionRemoteDataSource>(),
      localDataSource: sl<UserSessionLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<SpecialityLocalDataSource>(
        () => SpecialityLocalDataSource(),
  );
  sl.registerLazySingleton<SpecialityRemoteDataSource>(
        () => SpecialityRemoteDataSource(sl<SupabaseService>()),
  );
  sl.registerLazySingleton<SpecialityRepository>(
    () => SpecialityRepositoryImpl(
      remoteDataSource: sl<SpecialityRemoteDataSource>(),
      localDataSource: sl<SpecialityLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<ClinicLocalDataSource>(
        () => ClinicLocalDataSource(),
  );
  sl.registerLazySingleton<ClinicRemoteDataSource>(
        () => ClinicRemoteDataSource(sl<SupabaseService>()),
  );

  sl.registerLazySingleton<ClinicRepository>(
    () => ClinicRepositoryImpl(
      remoteDataSource: sl<ClinicRemoteDataSource>(),
      localDataSource: sl<ClinicLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<DoctorLocalDataSource>(
        () => DoctorLocalDataSource(),
  );
  sl.registerLazySingleton<DoctorRemoteDataSource>(
        () => DoctorRemoteDataSource(sl<SupabaseService>()),
  );

  sl.registerLazySingleton<DoctorRepository>(
        () => DoctorRepositoryImpl(
      remoteDataSource: sl<DoctorRemoteDataSource>(),
      localDataSource: sl<DoctorLocalDataSource>(),
    ),
  );
}
