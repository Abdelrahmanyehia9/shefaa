import 'package:shefaa/core/models/favorite.dart';

sealed class FavoriteStates {
  const FavoriteStates();
}

final class FavoriteStatesInitial extends FavoriteStates {
  const FavoriteStatesInitial();
}

final class FavoriteStatesLoaded extends FavoriteStates {
  final List<Favorite> favorite;

  const FavoriteStatesLoaded({required this.favorite});
}

final class FavoriteStatesToggled extends FavoriteStates {
  final bool isAdded;
  final List<Favorite> favorites;

  const FavoriteStatesToggled({required this.isAdded, required this.favorites});
}
