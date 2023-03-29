import '../../common/constants.dart';

class Pagination {
  final int limit;
  final int offset;
  final int total;

  const Pagination({
    this.limit = PaginationConstant.lowLimit,
    this.offset = 0,
    this.total = 0,
  });

  bool get canNext => offset + limit == total;

  int get currentPage => total ~/ limit + 1;

  int get firstPage => 1;

  int get nextPage => currentPage + 1;

  int get size => limit;

  @override
  String toString() {
    return '{"limit": $limit, "offset": $offset, "total": $total}';
  }
}

class CoursePagination {
  int limit;
  int offset;
  int total;

  CoursePagination({
    this.limit = 10,
    this.offset = 0,
    this.total = 0,
  });

  bool get canNext => offset + limit == total;

  int get currentPage => total ~/ limit;

  int get firstPage => 1;

  int get nextPage => canNext == true ? currentPage : currentPage + 1;

  int get size => limit;

  void setTotal(List<dynamic>? list) {
    total = list?.length ?? 0;
  }

  @override
  String toString() {
    return '{"limit": $limit, "offset": $offset, "total": $total}';
  }
}
