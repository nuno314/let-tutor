import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/data/models/teacher.dart';

import 'date_range.entity.dart';

class TutorListFilter {
  final List<Teacher> teachersFilter;
  final List<Teacher> teachers;
  final List<Specialty> specialties;
  final List<TutorNationality> nationalities;
  final DateRange? dateRange;

  const TutorListFilter({
    this.teachersFilter = const [],
    this.teachers = const [],
    this.specialties = const [],
    this.nationalities = const [],
    this.dateRange,
  });

  TutorListFilter copyWith({
    List<Teacher>? teachersFilter,
    List<Teacher>? teachers,
    List<Specialty>? specialties,
    List<TutorNationality>? nationalities,
    DateRange? dateRange,
  }) {
    return TutorListFilter(
      teachersFilter: teachersFilter ?? this.teachersFilter,
      teachers: teachers ?? this.teachers,
      specialties: specialties ?? this.specialties,
      dateRange: dateRange ?? this.dateRange,
      nationalities: nationalities ?? this.nationalities,
    );
  }

  TutorListFilter copyWithNullable({
    List<Teacher>? teachersFilter,
    List<Teacher>? teachers,
    List<Specialty>? specialties,
    List<TutorNationality>? nationalities,
    DateRange? dateRange,
  }) {
    return TutorListFilter(
      teachersFilter: teachersFilter ?? this.teachersFilter,
      teachers: teachers ?? [],
      specialties: specialties ?? [],
      dateRange: dateRange,
      nationalities: nationalities ?? [],
    );
  }

  DateTime? get from => dateRange?.from;
  DateTime? get to => dateRange?.to;

  Map<String, dynamic> get where => {
        if (specialties.isNotEmpty)
          'specialties': specialties.contains(Specialty.all)
              ? []
              : specialties.map((e) => e.id).toList(),
        if (nationalities.isNotEmpty)
          'nationality': {
            'isVietNamese': nationalities.contains(TutorNationality.vietnamese),
            'isNative': nationalities.contains(TutorNationality.native),
          }..removeWhere((key, value) =>
              nationalities.contains(TutorNationality.foreign)
                  ? value == true
                  : value == false)
      };
}
