import 'package:shefaa/core/models/favorite.dart';

class FavoriteLocalDataSource {
  Future<List<Favorite>> getFavorite() async {
    return [];
  }

  Future<void> addToFavorite(Favorite fav) async {
    return;
  }

  Future<void> removeFromFavorite(Favorite fav) async {
    return;
  }

  Future<void> removeAll() async {
    return;
  }

  Future<bool> isInFavorite(Favorite fav) async {
    return false;
  }
}
