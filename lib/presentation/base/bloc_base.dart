part of 'base.dart';

abstract class AppBlocBase<E, S> extends Bloc<E, S> {
  Function(ErrorData)? errorHandler;

  LocalDataManager get localDataManager => injector.get();

  AppBlocBase(S s) : super(s);

  EventTransformer<T> debounceSequential<T>(Duration duration) {
    return (events, mapper) =>
        events.debounceTime(duration).asyncExpand(mapper);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    LogUtils.e('onError', error, stackTrace);
    super.onError(error, stackTrace);
  }
}
