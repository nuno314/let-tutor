import '../../common/utils.dart';

T? asOrNull<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  if (value != null) {
    try {
      final tType = T.toString();
      if (tType == 'List<String>') {
        return value.cast<String>();
      }
      if (tType == 'List<double>') {
        return value.cast<double>();
      }
      if (tType == 'String') {
        return value.toString() as T;
      }
      if (tType == 'DateTime' && value is String) {
        return DateTime.parse(value).toLocal() as T;
      }
      if (value is num) {
        if (tType == 'double') {
          return value.toDouble() as T;
        }
        if (tType == 'int') {
          return value.toInt() as T;
        }
      }
      if (tType == 'Duration' && value is String) {
        return value.parseDuration() as T;
      }
    } catch (e, stackTrace) {
      LogUtils.e('asOrNullTest', e, stackTrace);
    }
  }
  return null;
}

String? parseDuration(Duration? duration) {
  return duration?.hhmmss;
}
