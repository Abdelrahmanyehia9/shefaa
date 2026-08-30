import 'package:shefaa/core/models/favorite.dart';
import 'package:shefaa/features/favorite/domain/repository/favorite_repository.dart';

class ToggleFavoriteUseCase {
  final FavoriteRepository _repository;
  const ToggleFavoriteUseCase(this._repository);

  Future<void> call(bool isFavorite, Favorite fav) async {
    if (isFavorite) return _repository.removeFromFavorite(fav);
    return _repository.addToFavorite(fav);
  }
}
