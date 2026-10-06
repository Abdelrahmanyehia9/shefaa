import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/location/data/models/user_location.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/domain/usecase/add_location_use_case.dart';

class AddLocationCubit extends Cubit<BaseState<UserLocationEntity>> {
  final AddLocationUseCase _useCase;

  AddLocationCubit(this._useCase) : super(const .initial());

  Future<void> addLocation({
    required UserLocation location
  }) async {
    safeEmit(const .loading());
    final result = await _useCase.call(location);
    result.fold((e) => safeEmit(.failure(e)), (s) => safeEmit(.success(s)));
  }
}
