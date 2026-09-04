import 'package:shefaa/core/models/medical.dart';

sealed class FavoriteStates {
  const FavoriteStates();
}

final class FavoriteStatesInitial extends FavoriteStates {
  const FavoriteStatesInitial();
}

final class FavoriteStatesLoaded extends FavoriteStates {
  final List<Medical> favorite;

  const FavoriteStatesLoaded({required this.favorite});
}

final class FavoriteStatesToggled extends FavoriteStates {
  final bool isAdded;
  final List<Medical> favorites;

  const FavoriteStatesToggled({required this.isAdded, required this.favorites});
}
