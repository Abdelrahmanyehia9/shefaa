import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/domain/usecase/get_all_locations_use_case.dart';

class GetAllLocationsCubit extends Cubit<BaseState<List<UserLocationEntity>>> {
  final GetAllLocationsUseCase _useCase;

  GetAllLocationsCubit(this._useCase) : super(const .initial());

   List<UserLocationEntity> _locations = [];

  Future<void> getAllLocations() async {
    safeEmit(const .loading());
    final result = await _useCase.call();
    result.fold((e) => safeEmit(.failure(e)), (s) {
      if (s.isEmpty) return safeEmit(const .empty());
      _locations=s;
      safeEmit(.success(_locations));
    });
  }

  void selectLocation(int locationId,) {
    for (var i = 0; i < _locations.length; i++) {
      _locations[i] = _locations[i].copyWith(
        isSelected: _locations[i].id == locationId,
      );
    }
    safeEmit(.success(List.unmodifiable(_locations)));
  }

}
