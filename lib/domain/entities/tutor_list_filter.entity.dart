import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/data/models/teacher.dart';

import 'date_range.entity.dart';

class TutorListFilter {
  final List<Teacher> teachersFilter;
  final List<Teacher> teachers;
  final List<Specialty> specialties;
  final List<TutorNationality> nationalities;

  const TutorListFilter({
    this.teachersFilter = const [],
    this.teachers = const [],
    this.specialties = const [],
    this.nationalities = const [],
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
      nationalities: nationalities ?? this.nationalities,
    );
  }

  TutorListFilter copyWithNullable({
    List<Teacher>? teachersFilter,
    List<Teacher>? teachers,
    List<Specialty>? specialties,
    List<TutorNationality>? nationalities,
  }) {
    return TutorListFilter(
      teachersFilter: teachersFilter ?? this.teachersFilter,
      teachers: teachers ?? [],
      specialties: specialties ?? [],
      nationalities: nationalities ?? [],
    );
  }

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
