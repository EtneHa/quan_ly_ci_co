class PaginationParams {
  final int page;
  final int limit;
  final String? search;

  PaginationParams({this.page = 1, this.limit = 10, this.search});

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'search': search
    };
  }

  PaginationParams copyWith({
    int? page,
    int? limit,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}