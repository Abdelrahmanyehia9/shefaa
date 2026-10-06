import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/domain/usecase/select_location_use_case.dart';

class SelectLocationCubit extends Cubit<BaseState<UserLocationEntity>> {
  final SelectLocationUseCase _useCase;

  SelectLocationCubit(this._useCase) : super(const .initial());

  Future<void> selectLocation(UserLocationEntity l) async {
    safeEmit(const .loading());
    final result = await _useCase.call(locId: l.id);
    result.fold((e) => safeEmit(.failure(e)), (s) => safeEmit(.success(s)));
  }
}
