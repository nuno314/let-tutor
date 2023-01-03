import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../common/services/auth_service.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';
import '../../../../route/route_list.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends AppBlocBase<SplashEvent, SplashState> {
  // late final _configRepo = injector.get<ConfigRepository>();
  late final _authService = injector.get<AuthService>();

  SplashBloc() : super(SplashInitialState()) {
    on<SplashInitialEvent>(initial);
  }

  Future<void> initial(
    SplashInitialEvent event,
    Emitter<SplashState> emitter,
  ) async {
    print('go');
    await _configServices();
    // await _configRepo.getAppSetting();
    print('done');

    emitter(SplashFinishState(
      isLoggedIn ? RouteList.dashboard : RouteList.signIn,
    ));
  }

  Future<void> _configServices() async {
    await _authService.init();
    if (_authService.isSignedIn) {
      await _authService.refreshToken();
    }
  }
}
