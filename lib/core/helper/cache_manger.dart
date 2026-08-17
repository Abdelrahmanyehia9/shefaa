import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/app_exception.dart';
import 'package:shefaa/core/helper/either.dart';

typedef LocalGetter<T> = Future<T?> Function();
typedef RemoteGetter<T> = Future<T> Function();
typedef LocalSaver<T> = Future<void> Function(T data);

class CacheManger {
  const CacheManger._();
  static CacheManger get instance => const CacheManger._();
  Future<Either<AppException, T>> cacheFirst<T>({
    required LocalGetter<T> getLocal,
    required RemoteGetter<T> getRemote,
    required LocalSaver<T> saveLocal,
    required bool Function(T?) cacheMiss,
    bool forceRefresh = false,
    bool refreshInBackground = true,
  }) async {
    try {
      if (forceRefresh) {
        final remote = await getRemote();
        await saveLocal(remote);
        return right(remote);
      }

      final local = await getLocal();
      if (!cacheMiss(local)) {
        if (refreshInBackground) {
          _refresh(getRemote: getRemote, saveLocal: saveLocal);
        }
        return right(local as T);
      }

      final remote = await getRemote();
      await saveLocal(remote);
      return right(remote);
    } catch (e) {
      return left(e.toAppException());
    }
  }

  Future<Either<AppException, T>> networkFirst<T>({
    required LocalGetter<T> getLocal,
    required RemoteGetter<T> getRemote,
    required LocalSaver<T> saveLocal,
    required bool Function(T?) cacheMiss,
  }) async {
    try {
      final remote = await getRemote();
      await saveLocal(remote);
      return right(remote);
    } catch (e) {
      try {
        final local = await getLocal();
        if (!cacheMiss(local)) {
          return right(local as T);
        }
      } catch (_) {}
      return left(e.toAppException());
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
