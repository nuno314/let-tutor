import '../../../di/di.dart';
import 'local/local_data_manager.dart';
import 'remote/app_api_service.dart';

mixin DataRepository {


  late final localDataManager = injector.get<LocalDataManager>();
}
