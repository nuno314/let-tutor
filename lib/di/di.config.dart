// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../common/services/auth_service.dart' as _i5;
import '../common/services/implementation/app_auth_service.dart' as _i6;
import '../data/data_source/local/preferences_helper/preferences_helper.dart'
    as _i7;
import '../data/data_source/remote/app_api_service.dart' as _i3;
import '../presentation/common_bloc/app_data_bloc.dart' as _i4;
import '../presentation/theme/theme_dialog.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AppApiService>(() => _i3.AppApiService());
  gh.singletonAsync<_i4.AppDataBloc>(() => _i4.AppDataBloc.create());
  gh.singleton<_i5.AuthService>(_i6.AppAuthService());
  gh.factory<_i7.PreferencesHelper>(() => _i7.PreferencesHelperImpl());
  gh.factory<_i8.ThemeDialog>(() => _i8.ThemeDialog());
  return get;
}
