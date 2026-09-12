import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/usecase/get_all_doctors_use_case.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';
import 'package:shefaa/features/medical/shared/presentation/controller/base_medical_cubit.dart';

class GetAllDoctorsCubit extends BaseMedicalCubit<DoctorEntity> {
  final GetAllDoctorsUseCase _useCase;

  GetAllDoctorsCubit(this._useCase, {DoctorRequest? initialRequest})
      : super(initialRequest ?? const DoctorRequest());

  @override
  Future<PaginationData<DoctorEntity>> callUseCase(
      MedicalRequest request, {
        bool forceRefresh = false,
      }) {
    return _useCase.call(request, forceRefresh: forceRefresh);
  }
}