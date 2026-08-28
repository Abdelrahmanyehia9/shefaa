
typedef LocalGetter<T> = Future<T?> Function();
typedef RemoteGetter<T> = Future<T> Function();
typedef LocalSaver<T> = Future<void> Function(T data);
typedef ErrorHandler<T> = T Function(Object error);

class CacheManger {
  const CacheManger._();
  static CacheManger get instance => const CacheManger._();

  Future<T> cacheFirst<T>({
    required LocalGetter<T> getLocal,
    required RemoteGetter<T> getRemote,
    required LocalSaver<T> saveLocal,
    required bool Function(T?) cacheMiss,
    ErrorHandler<T>? onError,
    bool forceRefresh = false,
    bool refreshInBackground = true,
  }) async {
    try {
      if (forceRefresh) {
        final remote = await getRemote();
        await saveLocal(remote);
        return remote;
      }

      final local = await getLocal();
      if (!cacheMiss(local)) {
        if (refreshInBackground) {
          _refresh(getRemote: getRemote, saveLocal: saveLocal);
        }
        return local as T;
      }

      final remote = await getRemote();
      await saveLocal(remote);
      return remote;
    } catch (e) {
      try {
        final local = await getLocal();
        if (!cacheMiss(local)) {
          return local as T;
        }
      } catch (_) {}
      if (onError != null) return onError(e);
      rethrow;
    }
  }

  Future<T> networkFirst<T>({
    required LocalGetter<T> getLocal,
    required RemoteGetter<T> getRemote,
    required LocalSaver<T> saveLocal,
    required bool Function(T?) cacheMiss,
    ErrorHandler<T>? onError,
  }) async {
    try {
      final remote = await getRemote();
      await saveLocal(remote);
      return remote;
    } catch (e) {
      try {
        final local = await getLocal();
        if (!cacheMiss(local)) {
          return local as T;
        }
      } catch (_) {}
      if (onError != null) return onError(e);
      rethrow;
    }
  }

  void _refresh<T>({
    required RemoteGetter<T> getRemote,
    required LocalSaver<T> saveLocal,
  }) {
    Future.microtask(() async {
      try {
        final remote = await getRemote();
        await saveLocal(remote);
      } catch (_) {}
    });
  }
}