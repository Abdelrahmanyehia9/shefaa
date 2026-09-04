import 'package:shefaa/core/models/medical.dart';

abstract class FavoriteRepository {
  Future<List<Medical>> getFavorites();
  Future<void> addToFavorite(Medical fav);
  Future<void> removeFromFavorite(Medical fav);
  Future<void> removeAll();
}
