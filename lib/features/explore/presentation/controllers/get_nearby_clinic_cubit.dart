import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/explore/domain/usecase/get_nearby_clinics_use_case.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_mixin.dart';

class GetNearbyClinicCubit
    extends Cubit<BaseState<PaginationData<ClinicEntity>>>
    with PaginatedMixin {
  final GetNearbyClinicsUseCase _useCase;
  LatLong? _coordinates;
  double? _zoom;

  GetNearbyClinicCubit(this._useCase) : super(const .initial());

  Future<void> getNearbyClinics(LatLong? coordinates, double? zoom) {
    _coordinates = coordinates;
    _zoom = zoom;

    return loadFirstPage(null, forceRefresh: true);
  }

  @override
  Future<PaginationData<ClinicEntity>> fetchPage(
    key,
    int page, {
    bool forceRefresh = false,
  }) {
    return _useCase.call(
      coordinates: _coordinates,
      page: page,
      radius: _zoom,
    );
  }

  @override
  void onLoading() => safeEmit(const .loading());

  @override
  void onEmpty() => safeEmit(const .empty());

  @override
  void onSuccess(PaginationData<ClinicEntity> data) => safeEmit(.success(data));
}
