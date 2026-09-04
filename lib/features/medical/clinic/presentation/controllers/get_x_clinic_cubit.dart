import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_details_entity.dart';
import 'package:shefaa/features/medical/clinic/domain/usecase/get_x_clinic_use_case.dart';

class GetXClinicCubit extends Cubit<BaseState<ClinicDetailsEntity>> {
  final GetXClinicUseCase _useCase;

  GetXClinicCubit(this._useCase) : super(const .initial());

  Future<void> getXClinic({required int clinicId}) async {
    safeEmit(const .loading());
    final result = await _useCase.call(clinicId);
    result.fold((e) => safeEmit(.failure(e)), (c) => safeEmit(.success(c)));
  }
}
