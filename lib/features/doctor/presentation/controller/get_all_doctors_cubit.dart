import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/doctor/domain/usecase/get_all_doctors_use_case.dart';

class GetAllDoctorsCubit
    extends Cubit<BaseState<PaginationData<DoctorEntity>>> {
  final GetAllDoctorsUseCase _useCase;
  GetAllDoctorsCubit(this._useCase) : super(const .initial());
  DoctorRequest request = const DoctorRequest();

  Future<void> getDoctors({bool forceRefresh = false}) async {
    safeEmit(const .loading());
    final doctors = await _useCase.call(request, forceRefresh: forceRefresh);
    if (doctors.data.isEmpty) return safeEmit(const .empty());
    safeEmit(.success(doctors));
  }
}
