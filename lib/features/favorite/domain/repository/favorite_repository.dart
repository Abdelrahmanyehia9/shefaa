import 'package:shefaa/core/models/favorite.dart';

abstract class FavoriteRepository {
  Future<List<Favorite>> getFavorites();
  Future<void> addToFavorite(Favorite fav);
  Future<void> removeFromFavorite(Favorite fav);
  Future<void> removeAll();
}
