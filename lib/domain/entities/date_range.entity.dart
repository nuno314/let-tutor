class DateRange {
  final DateTime? from;
  final DateTime? to;

  DateRange({this.from, this.to});

  DateRange copyWith({
    DateTime? from,
    DateTime? to,
  }) {
    return DateRange(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  bool campare(DateRange other) {
    final all = [from, to, other.from, other.to];
    if (all.any((e) => e == null)) {
      final countNUll = all.where((e) => e == null).length;
      if (countNUll == 4) {
        return true;
      }
      if (countNUll % 2 != 0) {
        return false;
      } else {
        if (countNUll == all.length) {
          return true;
        } else if (all[0] == null &&
            all[2] == null &&
            all[1]!.difference(all[3]!).inMilliseconds == 0) {
          return true;
        } else if (all[1] == null &&
            all[3] == null &&
            all[0]!.difference(all[2]!).inMilliseconds == 0) {
          return true;
        } else {
          return false;
        }
      }
    }
    // case all not null
    return all[1]!.difference(all[3]!).inMilliseconds == 0 &&
        all[0]!.difference(all[2]!).inMilliseconds == 0;
  }
}
