import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/models/course.dart';
import 'package:let_tutor/domain/entities/pagination.entity.dart';

class CoursesFilter {
  final List<Specialty> specialties;
  final List<Category> categoriesFilter;
  final List<Category> categories;
  final String? orderBy;
  final Pagination? pagination;

  const CoursesFilter({
    this.specialties = const [],
    this.categoriesFilter = const [],
    this.categories = const [],
    this.orderBy,
    this.pagination,
  });

  CoursesFilter copyWith({
    List<Specialty>? specialties,
    List<Category>? categoriesFilter,
    List<Category>? categories,
    String? orderBy,
    Pagination? pagination,
  }) =>
      CoursesFilter(
        specialties: specialties ?? this.specialties,
        categoriesFilter: categoriesFilter ?? this.categoriesFilter,
        categories: categories ?? this.categories,
        orderBy: orderBy ?? this.orderBy,
        pagination: pagination ?? this.pagination,
      );

  String get filter {
    var payload = '';
    if (specialties.isNotEmpty)
      payload +=
          specialties.map((e) => 'level[]:' + e.index.toString() + '&').join();
    if (categories.isNotEmpty)
      payload += categories.map((e) => 'level[]:' + e.id! + '&').join();
    if (orderBy.isNotNullOrEmpty) {
      payload += 'orderBy[]' + orderBy! + '&';
    }
    if (pagination != null) {
      payload += 'page' + pagination!.currentPage.toString();
    }
    return payload;
  }
}
