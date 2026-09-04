import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/models/medical.dart';
import 'package:shefaa/features/favorite/presentation/controller/favorite_cubit.dart';
import 'package:shefaa/features/favorite/presentation/controller/favorite_states.dart';

class FavoriteBuilder extends StatelessWidget {
  final Medical? favorite;
  final Widget Function(
    FavoriteCubit cubit,
    List<Medical>? favorites,
    bool inFav,
  )
  builder;
  const FavoriteBuilder({super.key, this.favorite, required this.builder});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteCubit>();
    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        final isFavorite =
            favorite != null && cubit.favorite.contains(favorite);
        return builder.call(cubit, cubit.favorite, isFavorite);
      },
    );
  }
}
