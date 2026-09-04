import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_details_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/usecase/get_x_doctor_use_case.dart';

class GetXDoctorCubit extends Cubit<BaseState<DoctorDetailsEntity>> {
  final GetXDoctorUseCase _useCase;

  GetXDoctorCubit(this._useCase) : super(const .initial());

  Future<void> getXDoctor(int id) async {
    safeEmit(const .loading());
    final result = await _useCase.call(id);
    result.fold((e) => safeEmit(.failure(e)), (d) => safeEmit(.success(d)));
  }
}
