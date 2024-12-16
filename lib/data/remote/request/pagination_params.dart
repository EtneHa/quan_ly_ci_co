class PaginationParams {
  final int page;
  final int limit;

  PaginationParams({this.page = 1, this.limit = 10});

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
    };
  }
}