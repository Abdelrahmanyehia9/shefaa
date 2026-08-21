part of "get_it.dart";

Future<void> _registerDataDependencies() async {


  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSource(sl<AuthService>()));
  sl.registerLazySingleton<AuthRepository>(()=>AuthRepositoryImpl(sl<AuthRemoteDataSource>()));



}
