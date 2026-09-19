
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
    currentPage: 1,
    perPage: 0,
  );

  PaginationData<T> copyWith({
    List<T>? data,
    int? totalCount,
    bool? hasMore,
    int? currentPage,
    int? perPage,
  }) {
    return PaginationData<T>(
      data: data ?? this.data,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
    );
  }}


extension PaginationDataUpdate<T> on PaginationData<T> {
  PaginationData<T> updateItem(
      bool Function(T item) test,
      T Function(T item) update,
      ) {
    final index = data.indexWhere(test);
    if (index == -1) return this;

    final updatedList = [...data];
    updatedList[index] = update(updatedList[index]);

    return copyWith(data: updatedList);
  }
}