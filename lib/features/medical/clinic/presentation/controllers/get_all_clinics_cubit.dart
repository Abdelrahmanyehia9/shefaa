import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/domain/usecase/get_all_clinics_use_case.dart';
import 'package:shefaa/features/medical/shared/presentation/controller/base_medical_cubit.dart';

class GetAllClinicsCubit extends BaseMedicalCubit<ClinicEntity> {
  final GetAllClinicsUseCase _useCase;
  final ClinicRequest _request = const ClinicRequest();

  GetAllClinicsCubit(this._useCase);

  @override
  Future<PaginationData<ClinicEntity>> fetchPage(
      int? specialityId,
      int page, {
        bool forceRefresh = false,
      }) {
    final request = _request.copyWith(specialityId: specialityId, page: page);
    return _useCase.call(request, forceRefresh);
  }
}
