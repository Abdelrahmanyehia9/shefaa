import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/location/domain/usecase/delete_location_use_case.dart';

class DeleteLocationCubit extends Cubit<BaseState<Unit>> {
  final DeleteLocationUseCase _useCase;

  DeleteLocationCubit(this._useCase) : super(const .initial());

  Future<void> deleteLocation(int id) async {
    safeEmit(const .loading());
    final result = await _useCase.call(id: id);
    result.fold((e) => safeEmit(.failure(e)), (s) => safeEmit(.success(s)));
  }
}
