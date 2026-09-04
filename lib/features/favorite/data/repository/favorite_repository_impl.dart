import 'package:shefaa/core/models/medical.dart';
import 'package:shefaa/features/favorite/data/datasource/favorite_local_data_source.dart';
import 'package:shefaa/features/favorite/domain/repository/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;
  const FavoriteRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Medical>> getFavorites() {
    return localDataSource.getFavorite();
  }

  @override
  Future<void> addToFavorite(Medical fav) {
    return localDataSource.addToFavorite(fav);
  }

  @override
  Future<void> removeFromFavorite(Medical fav) {
    return localDataSource.removeFromFavorite(fav);
  }

  @override
  Future<void> removeAll() {
    return localDataSource.removeAll();
  }
}
