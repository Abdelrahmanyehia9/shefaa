part of "get_it.dart";

Future<void> _registerDataDependencies() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<AuthService>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton<UserSessionRemoteDataSource>(
    () => UserSessionRemoteDataSource(sl<AuthService>(), sl<DatabaseService>()),
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
}
