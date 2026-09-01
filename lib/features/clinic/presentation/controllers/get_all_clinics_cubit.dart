import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/clinic/domain/usecase/get_all_clinics_use_case.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_mixin.dart';

class GetAllClinicsCubit extends Cubit<BaseState<PaginationData<ClinicEntity>>>
    with PaginatedMixin<int?, ClinicEntity> {
  final GetAllClinicsUseCase _useCase;
  GetAllClinicsCubit(this._useCase) : super(const .initial());
  final ClinicRequest _request = const ClinicRequest();
  int? _currentKey;

  @override
  Future<PaginationData<ClinicEntity>> fetchPage(
    int? specialityId,
    int page, {
    bool forceRefresh = false,
  }) {
    final request = _request.copyWith(specialityId: specialityId, page: page);
    return _useCase.call(request, forceRefresh);
  }

  Future<void> getClinics({bool forceRefresh = false}) {
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

  Future<void> loadMoreClinics() {
    return loadMore(_currentKey);
  }

  @override
  bool get enableCache => true;
}
