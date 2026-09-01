import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/doctor/domain/usecase/get_all_doctors_use_case.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_mixin.dart';

class GetAllDoctorsCubit extends Cubit<BaseState<PaginationData<DoctorEntity>>>
    with PaginatedMixin<int?, DoctorEntity> {
  final GetAllDoctorsUseCase _useCase;
  GetAllDoctorsCubit(this._useCase) : super(const .initial());
  DoctorRequest request = const DoctorRequest();
  final DoctorRequest _request = const DoctorRequest();
  int? _currentKey;
  Future<void> getDoctors({bool forceRefresh = false}) async {
    _currentKey = null;
    return loadFirstPage(_currentKey, forceRefresh: forceRefresh);
  }

  @override
  bool get enableCache => true;

  Future<void> fetchBySpeciality(
    int? specialityId, {
    bool forceRefresh = false,
  }) {
    _currentKey = specialityId;
    return loadFirstPage(specialityId, forceRefresh: forceRefresh);
  }

  Future<void> loadMoreDoctors() {
    return loadMore(_currentKey);
  }

  @override
  Future<PaginationData<DoctorEntity>> fetchPage(
    int? specialityId,
    int page, {
    bool forceRefresh = false,
  }) {
    final request = _request.copyWith(specialityId: specialityId, page: page);
    return _useCase.call(request, forceRefresh: forceRefresh);
  }
}
