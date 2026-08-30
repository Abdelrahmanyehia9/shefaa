import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/shared/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/domain/usecase/get_specialities_use_case.dart';

class GetSpecialitiesCubit extends Cubit<BaseState<List<SpecialityEntity>>> {
  final GetSpecialitiesUseCase _useCase;
  GetSpecialitiesCubit(this._useCase) : super(const .initial());
  Future<void> getSpecialities({bool forceRefresh = false}) async {
    safeEmit(const .loading());
    final result = await _useCase.call(forceRefresh: forceRefresh);
    if (result.isEmpty) return safeEmit(const .empty());
    safeEmit(.success(result));
  }
}
