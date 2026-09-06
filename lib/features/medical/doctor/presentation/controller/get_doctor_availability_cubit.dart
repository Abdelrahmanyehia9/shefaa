import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_availability_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/usecase/get_doctor_availability_use_case.dart';

class GetDoctorAvailabilityCubit
    extends Cubit<BaseState<List<DoctorAvailabilityEntity>>> {
  final GetDoctorAvailabilityUseCase _useCase;

  GetDoctorAvailabilityCubit(this._useCase) :super(const .initial());


  Future<void> getDoctorAvailability(int doctorId) async {
    safeEmit(const .loading());
    final doctor = await _useCase.call(doctorId);
    doctor.fold((e) => safeEmit(.failure(e)), (d) {
      if(d.isEmpty)return safeEmit(const .empty());
      safeEmit(.success(d));
    });
  }
}