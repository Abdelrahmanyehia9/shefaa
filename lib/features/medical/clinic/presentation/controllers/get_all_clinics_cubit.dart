import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/domain/usecase/get_all_clinics_use_case.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';
import 'package:shefaa/features/medical/shared/presentation/controller/base_medical_cubit.dart';

class GetAllClinicsCubit extends BaseMedicalCubit<ClinicEntity> {
  final GetAllClinicsUseCase _useCase;

  GetAllClinicsCubit(this._useCase, {ClinicRequest? initialRequest})
    : super(initialRequest ?? const ClinicRequest());

  @override
  Future<PaginationData<ClinicEntity>> callUseCase(
    MedicalRequest request, {
    bool forceRefresh = false,
  }) {
    return _useCase.call(request, forceRefresh);
  }
}
