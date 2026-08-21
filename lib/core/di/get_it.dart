import 'package:get_it/get_it.dart';
import 'package:shefaa/core/services/auth_service.dart';
import 'package:shefaa/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:shefaa/features/auth/data/repository/auth_repository_impl.dart';
import 'package:shefaa/features/auth/domain/repository/auth_repository.dart';
import 'package:shefaa/features/auth/domain/usecase/sign_in_email_and_password_use_case.dart';
import 'package:shefaa/features/auth/presentation/controller/sign_in_email_and_password_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'data_di.dart';
part 'domain_di.dart';
part 'presentation_di.dart';

final GetIt sl = GetIt.instance;

class DI {
  const DI._();

  static Future<void> init() async {
    await Future.wait([_registerSingleton(), _registerFactories()]);
  }

  static Future<void> _registerSingleton() async {
    final SupabaseClient client = Supabase.instance.client;
    sl.registerLazySingleton<AuthService>(()=>AuthService(client));
    _registerDataDependencies();
  }

  static Future<void> _registerFactories() async {
    _registerDomainDependencies();
    _registerPresentationDependencies();
  }

  static Future<void> reset() async {
    await sl.reset();
  }
}
