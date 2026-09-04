import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/usecase/get_all_doctors_use_case.dart';
import 'package:shefaa/features/medical/shared/presentation/controller/base_medical_cubit.dart';

class GetAllDoctorsCubit extends BaseMedicalCubit<DoctorEntity> {
  final GetAllDoctorsUseCase _useCase;
  final DoctorRequest _request = const DoctorRequest();

  GetAllDoctorsCubit(this._useCase);

  @override
  Future<PaginationData<DoctorEntity>> fetchPage(
      int? specialityId,
      int page, {
        bool forceRefresh = false,
      }) {
    final request = _request.copyWith(specialityId: specialityId, page: page);
    return _useCase.call(request, forceRefresh: forceRefresh);
  }
}
