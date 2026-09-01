import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/models/pagination_data.dart';

mixin PaginatedMixin<K, T> on Cubit<BaseState<PaginationData<T>>> {
  /// Current pagination state for each key.
  final Map<K, PaginationData<T>> _pagination = {};

  /// Prevents multiple loadMore requests for the same key.
  final Map<K, bool> _loadingMore = {};

  /// Ignores stale responses when a newer request for the same key started.
  final Map<K, int> _requestId = {};

  /// Override this when this Cubit needs caching.
  bool get enableCache => false;

  final Map<K, PaginationData<T>> _cache = {};

  Future<PaginationData<T>> fetchPage(
    K key,
    int page, {
    bool forceRefresh = false,
  });

  PaginationData<T>? paginationFor(K key) => _pagination[key];

  PaginationData<T>? cacheFor(K key) => enableCache ? _cache[key] : null;

  bool isLoadingMore(K key) => _loadingMore[key] ?? false;

  Future<void> loadFirstPage(K key, {bool forceRefresh = false}) async {
    if (enableCache && !forceRefresh) {
      final cached = _cache[key];
      if (cached != null) {
        _pagination[key] = cached;
        safeEmit(.success(cached));
        return;
      }
    }

    final myRequestId = (_requestId[key] ?? 0) + 1;
    _requestId[key] = myRequestId;

    safeEmit(const .loading());

    final data = await fetchPage(key, 1, forceRefresh: forceRefresh);

    if (_requestId[key] != myRequestId) return;

    _pagination[key] = data;
    if (enableCache) _cache[key] = data;

    if (data.data.isEmpty) {
      safeEmit(const .empty());
      return;
    }

    safeEmit(.success(data));
  }

  Future<void> loadMore(K key) async {
    final current = _pagination[key];

    if (current == null || !current.hasMore || (_loadingMore[key] ?? false)) {
      return;
    }

    _loadingMore[key] = true;

    try {
      final nextPageData = await fetchPage(key, current.currentPage + 1);

      final merged = PaginationData<T>(
        data: [...current.data, ...nextPageData.data],
        totalCount: nextPageData.totalCount,
        hasMore: nextPageData.hasMore,
        currentPage: nextPageData.currentPage,
        perPage: nextPageData.perPage,
      );

      _pagination[key] = merged;
      if (enableCache) _cache[key] = merged;

      safeEmit(.success(merged));
    } finally {
      _loadingMore[key] = false;
    }
  }

  void clearCache([K? key]) {
    if (!enableCache) return;
    key != null ? _cache.remove(key) : _cache.clear();
  }

  void clearPagination(K key) {
    _pagination.remove(key);
    _loadingMore.remove(key);
    _requestId.remove(key);
  }

  void clearAll() {
    _pagination.clear();
    _loadingMore.clear();
    _requestId.clear();
    _cache.clear();
  }
}
