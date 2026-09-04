import 'package:shefaa/core/models/medical.dart';

class FavoriteLocalDataSource {
  Future<List<Medical>> getFavorite() async {
    return [];
  }

  Future<void> addToFavorite(Medical fav) async {
    return;
  }

  Future<void> removeFromFavorite(Medical fav) async {
    return;
  }

  Future<void> removeAll() async {
    return;
  }

  Future<bool> isInFavorite(Medical fav) async {
    return false;
  }
}
