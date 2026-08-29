import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';

class LocalSearchState<T> extends Equatable {
  final List<T> allItems;
  final String query;

  const LocalSearchState({
    required this.allItems,
    this.query = "",
  });

  bool get isSearching => query.trim().isNotEmpty;

  LocalSearchState<T> copyWith({
    List<T>? allItems,
    String? query,
  }) {
    return LocalSearchState<T>(
      allItems: allItems ?? this.allItems,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [allItems, query];
}
class LocalSearchCubit<T> extends Cubit<LocalSearchState<T>> {
  LocalSearchCubit({
    required List<T> items,
    required this.matcher,
  }) : super(
    LocalSearchState<T>(
      allItems: items,
    ),
  );

  final bool Function(T item, String normalizedQuery) matcher;

  List<T> get filteredItems {
    if (!state.isSearching) return state.allItems;

    final query = state.query.trim().toLowerCase();

    return state.allItems
        .where((item) => matcher(item, query))
        .toList();
  }

  void search(String? query) {
    if (query == null) return;

    safeEmit(state.copyWith(query: query));
  }

  void clearSearch() {
    safeEmit(state.copyWith(query: ""));
  }

  void updateItems(List<T> items) {
    safeEmit(state.copyWith(allItems: items));
  }
}