import '../../../di/di.dart';
import 'local/local_data_manager.dart';

mixin DataRepository {
  late final localDataManager = injector.get<LocalDataManager>();
}
