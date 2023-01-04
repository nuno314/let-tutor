import 'date_range.entity.dart';
import '../../../../common/utils.dart';

class ScheduleFilter {
  final DateRange? dateRange;

  const ScheduleFilter({
    this.dateRange,
  });

  ScheduleFilter copyWith({
    DateRange? dateRange,
  }) =>
      ScheduleFilter(
        dateRange: dateRange ?? this.dateRange,
      );

  ScheduleFilter copyWithNullable({
    DateRange? dateRange,
  }) =>
      ScheduleFilter(
        dateRange: dateRange,
      );

  int get startTimestamp =>
      dateRange?.from?.toUtc().millisecondsSinceEpoch ??
      DateTime.now().millisecondsSinceEpoch;
  int get endTimestamp =>
      dateRange?.to?.toUtc().millisecondsSinceEpoch ??
      DateTime.now().millisecondsSinceEpoch;

  DateTime get from =>
      dateRange?.from ?? DateTime.now().subtract(Duration(days: 7));
  DateTime get to => dateRange?.to ?? DateTime.now();

  String dateRangeToString(context) {
    return from.toDateWithWeekdayFormat(context) +
        ' - ' +
        to.toDateWithWeekdayFormat(context);
  }
}
