import 'package:shefaa/core/models/medical.dart';
import 'package:shefaa/features/favorite/domain/repository/favorite_repository.dart';

class GetFavoritesUseCase {
  final FavoriteRepository _repository;
  const GetFavoritesUseCase(this._repository);

  Future<List<Medical>> call() {
    return _repository.getFavorites();
  }
}
