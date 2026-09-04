import 'package:shefaa/core/models/medical.dart';
import 'package:shefaa/features/favorite/domain/repository/favorite_repository.dart';

class ToggleFavoriteUseCase {
  final FavoriteRepository _repository;
  const ToggleFavoriteUseCase(this._repository);

  Future<void> call(bool isFavorite, Medical fav) async {
    if (isFavorite) return _repository.removeFromFavorite(fav);
    return _repository.addToFavorite(fav);
  }
}
