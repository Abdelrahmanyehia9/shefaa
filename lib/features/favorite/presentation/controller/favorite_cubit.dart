import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/models/favorite.dart';
import 'package:shefaa/features/favorite/domain/usecase/get_favorites_use_case.dart';
import 'package:shefaa/features/favorite/domain/usecase/toggle_favorite_use_case.dart';
import 'package:shefaa/features/favorite/presentation/controller/favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  bool showConfirmAlert = true;

  FavoriteCubit({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoriteStatesInitial());

  final List<Favorite> _favorite = [];
  List<Favorite> get favorite => _favorite;

  Future<void> getFavorite() async {
    final favorite = await getFavoritesUseCase.call();
    _favorite.addAll(favorite);
    safeEmit(FavoriteStatesLoaded(favorite: favorite));
  }

  Future<void> toggleFavorite(Favorite fav) async {
    final int idx = _getIndex(fav);
    final bool inFavorite = idx != -1;
    if (inFavorite) {
      _favorite.removeAt(idx);
    } else {
      _favorite.add(fav);
    }
    toggleFavoriteUseCase.call(inFavorite, fav);
    safeEmit(FavoriteStatesToggled(isAdded: !inFavorite, favorites: _favorite));
  }

  int _getIndex(Favorite fav) {
    return _favorite.indexOf(fav);
  }
}
