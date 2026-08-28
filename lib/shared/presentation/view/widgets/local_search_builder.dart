import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/shared/presentation/controllers/local_search_cubit.dart';

class LocalSearchBuilder<T> extends StatefulWidget {
  const LocalSearchBuilder({
    super.key,
    required this.onInit,
    required this.onFiltered,
    required this.onEmpty,
    this.onSearch,
    this.buildWhen,
  });

  final Widget Function(BuildContext context, List<T> allItems ) onInit;
  final Widget Function(BuildContext context, List<T> filteredItems, String query)
  onFiltered;
  final Widget Function(BuildContext context, String query) onEmpty;
  final void Function(String query)? onSearch;
  final bool Function(LocalSearchState<T> previous, LocalSearchState<T> current)?
  buildWhen;

  @override
  State<LocalSearchBuilder<T>> createState() => _LocalSearchBuilderState<T>();
}

class _LocalSearchBuilderState<T> extends State<LocalSearchBuilder<T>> {
  late final LocalSearchCubit<T> _cubit;
  String? _lastQuery;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LocalSearchCubit<T>>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalSearchCubit<T>, LocalSearchState<T>>(
      bloc: _cubit,
      buildWhen: widget.buildWhen,
      builder: (context, state) {
        if (widget.onSearch != null && _lastQuery != state.query) {
          _lastQuery = state.query;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onSearch?.call(state.query);
          });
        }

        if (!state.isSearching) {
          return widget.onInit(context, state.allItems,);
        }

        final filtered = _cubit.filteredItems;

        if (filtered.isEmpty) {
          return widget.onEmpty(context, state.query);
        }

        return widget.onFiltered(context, filtered, state.query);
      },
    );
  }
}