import 'package:let_tutor/data/models/teacher.dart';

import 'date_range.entity.dart';

class TutorListFilter {
  final List<Teacher> teachersFilter;
  final List<Teacher> teachers;
  final List<String> categories;
  final DateRange? dateRange;

  const TutorListFilter({
    this.teachersFilter = const [],
    this.teachers = const [],
    this.categories = const [],
    this.dateRange,
  });

  TutorListFilter copyWith({
    List<Teacher>? teachersFilter,
    List<Teacher>? teachers,
    List<String>? categories,
    DateRange? dateRange,
  }) {
    return TutorListFilter(
      teachersFilter: teachersFilter ?? this.teachersFilter,
      teachers: teachers ?? this.teachers,
      categories: categories ?? this.categories,
      dateRange: dateRange ?? this.dateRange,
    );
  }

  DateTime? get from => dateRange?.from;
  DateTime? get to => dateRange?.to;
}
