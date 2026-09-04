import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_mixin.dart';

abstract class BaseMedicalCubit<T> extends Cubit<BaseState<PaginationData<T>>>
    with PaginatedMixin<int?, T> {
  BaseMedicalCubit() : super(const .initial());

  int? _currentKey;

  Future<void> getAll({bool forceRefresh = false}) {
    _currentKey = null;
    return loadFirstPage(_currentKey, forceRefresh: forceRefresh);
  }

  Future<void> fetchBySpeciality(
      int? specialityId, {
        bool forceRefresh = false,
      }) {
    _currentKey = specialityId;
    return loadFirstPage(specialityId, forceRefresh: forceRefresh);
  }

  Future<void> loadMoreItems() {
    return loadMore(_currentKey);
  }

  @override
  bool get enableCache => true;
}