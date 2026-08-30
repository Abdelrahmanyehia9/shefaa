import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/clinic/domain/usecase/get_all_clinics_use_case.dart';

class GetAllClinicsCubit
    extends Cubit<BaseState<PaginationData<ClinicEntity>>> {
  final GetAllClinicsUseCase _useCase;
  GetAllClinicsCubit(this._useCase) : super(const .initial());
  ClinicRequest request = const ClinicRequest();

  Future<void> getClinics({bool forceRefresh = false}) async {
    safeEmit(const .loading());
    final clinics = await _useCase.call(request, forceRefresh);
    if (clinics.data.isEmpty) return safeEmit(const .empty());
    safeEmit(.success(clinics));
  }
}
