import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/local/local_data_manager.dart';
import 'di.config.dart';

GetIt get injector => GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<dynamic> configureDependencies() async {
  injector
    ..registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance(),
    )
    ..registerSingleton<LocalDataManager>(
      await LocalDataManager.init(),
    )
    ..registerSingleton<GoogleSignIn>(
      await GoogleSignIn.standard(
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      ),
    );
  return $initGetIt(injector);
}
