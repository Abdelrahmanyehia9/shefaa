class PaginationData<T> {
  final List<T> data;
  final int totalCount;
  final bool hasMore;
  final int currentPage;
  final int perPage;

  const PaginationData({
    required this.data,
    required this.totalCount,
    required this.hasMore,
    required this.currentPage,
    required this.perPage,
  });

  factory PaginationData.empty({List<T>? t}) => PaginationData<T>(
    data: t ?? [],
    totalCount: 0,
    hasMore: false,
    currentPage: 0,
    perPage: 0,
  );
}
