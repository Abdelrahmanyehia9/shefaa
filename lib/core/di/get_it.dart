import 'package:get_it/get_it.dart';

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
