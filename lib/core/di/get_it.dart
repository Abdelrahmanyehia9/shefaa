import 'package:get_it/get_it.dart';
import 'package:shefaa/core/cache/key_value_storage.dart';
import 'package:shefaa/core/cache/shared_pref_local_storage.dart';
import 'package:shefaa/core/services/auth_service.dart';
import 'package:shefaa/core/services/data_base_service.dart';
import 'package:shefaa/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:shefaa/features/auth/data/repository/auth_repository_impl.dart';
import 'package:shefaa/features/auth/domain/repository/auth_repository.dart';
import 'package:shefaa/features/auth/domain/usecase/sign_in_email_and_password_use_case.dart';
import 'package:shefaa/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:shefaa/features/auth/presentation/controller/sign_in_email_and_password_cubit.dart';
import 'package:shefaa/features/auth/presentation/controller/sign_up_email_and_password_cubit.dart';
import 'package:shefaa/features/profile/domain/usecase/complete_profile_use_case.dart';
import 'package:shefaa/features/profile/presentation/controller/complete_profile_cubit.dart';
import 'package:shefaa/shared/data/datasource/user_session_local_data_source.dart';
import 'package:shefaa/shared/data/datasource/user_session_remote_data_source.dart';
import 'package:shefaa/shared/data/repository/user_session_repository_impl.dart';
import 'package:shefaa/shared/domain/repository/user_session_repository.dart';
import 'package:shefaa/shared/domain/usecase/finish_intro_use_case.dart';
import 'package:shefaa/shared/domain/usecase/setup_auth_listeners_use_case.dart';
import 'package:shefaa/shared/domain/usecase/sign_out_use_case.dart';
import 'package:shefaa/shared/presentation/controllers/user_session_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'data_di.dart';

part 'domain_di.dart';

part 'presentation_di.dart';

final GetIt sl = GetIt.instance;

class DI {
  const DI._();

  static Future<void> init() async {
    await _registerSingleton();
    await _registerFactories();
  }

  static Future<void> _registerSingleton() async {
    await _setupLocalStorage();
    final SupabaseClient client = Supabase.instance.client;
    sl.registerLazySingleton<AuthService>(() => AuthService(client.auth));
    sl.registerLazySingleton<DatabaseService>(
      () => DatabaseService(client.rest),
    );

    await _registerDataDependencies();
  }

  static Future<void> _registerFactories() async {
    await _registerDomainDependencies();
    await _registerPresentationDependencies();
  }

  static Future<void> reset() async {
    await sl.reset();
  }

  static Future<void> _setupLocalStorage() async {
    sl.registerSingleton<KeyValueStorage>(
      await SharedPrefLocalStorage.create(),
    );
  }
}
