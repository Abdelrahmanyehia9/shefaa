import 'package:shefaa/core/models/favorite.dart';
import 'package:shefaa/features/favorite/domain/repository/favorite_repository.dart';

class GetFavoritesUseCase {
  final FavoriteRepository _repository;
  const GetFavoritesUseCase(this._repository);

  Future<List<Favorite>> call() {
    return _repository.getFavorites();
  }
}
