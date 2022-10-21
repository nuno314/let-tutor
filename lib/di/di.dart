import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di.config.dart';

GetIt coreInjector = GetIt.instance;

GetIt get injector => coreInjector;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<dynamic> configureDependencies() {
  return $initGetIt(injector);
}

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
