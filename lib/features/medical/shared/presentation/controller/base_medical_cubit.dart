import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_mixin.dart';

abstract class BaseMedicalCubit<T> extends Cubit<BaseState<PaginationData<T>>>
    with PaginatedMixin<int?, T> {
  BaseMedicalCubit(this._request) : super(const BaseState.initial());

  MedicalRequest _request;

  String get _debounceTag => 'medical_cubit_${identityHashCode(this)}';

  MedicalRequest get currentRequest => _request;

  Future<PaginationData<T>> callUseCase(
    MedicalRequest request, {
    bool forceRefresh = false,
  });

  @override
  Future<PaginationData<T>> fetchPage(
    int? specialityId,
    int page, {
    bool forceRefresh = false,
  }) {
    return callUseCase(
      _request.copyWith(specialityId: specialityId, page: page),
      forceRefresh: forceRefresh,
    );
  }

  Future<void> init({bool forceRefresh = false}) {
    return _load(_request.specialityId, forceRefresh: forceRefresh);
  }

  void fetchFiltered({
    required MedicalRequest request,
    bool forceRefresh = false,
  }) {
    final hadQuery = !_request.query.isNullOrEmpty;
    final hasQuery = !request.query.isNullOrEmpty;

    _request = request;

    if (hasQuery) {
      EasyDebounce.debounce(
        _debounceTag,
        const Duration(milliseconds: 500),
        () => _load(_request.specialityId, forceRefresh: true),
      );
      return;
    }
    _load(_request.specialityId, forceRefresh: forceRefresh || hadQuery);
  }

  Future<void> _load(int? specialityId, {required bool forceRefresh}) {
    EasyDebounce.cancel(_debounceTag);
    return loadFirstPage(specialityId, forceRefresh: forceRefresh);
  }

  Future<void> loadMoreItems() {
    return loadMore(_request.specialityId);
  }

  @override
  onSuccess(PaginationData<T> data) {
    safeEmit(.success(data));
  }

  @override
  onLoading() => safeEmit(const .loading());

  @override
  Future<void> close() {
    EasyDebounce.cancel(_debounceTag);
    clearAll();
    return super.close();
  }

  @override
  bool get enableCache => true;
}
