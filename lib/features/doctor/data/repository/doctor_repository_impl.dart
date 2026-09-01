import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/cache_manger.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/doctor/data/datasource/doctor_local_data_source.dart';
import 'package:shefaa/features/doctor/data/datasource/doctor_remote_data_source.dart';
import 'package:shefaa/features/doctor/data/models/doctor_details.dart';
import 'package:shefaa/features/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/doctor/data/models/doctor.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_details_entity.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/doctor/domain/repository/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;
  final DoctorLocalDataSource localDataSource;

  const DoctorRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<PaginationData<DoctorEntity>> getDoctors(
    DoctorRequest request, {
    bool forceRefresh = false,
  }) async {
    final doctors = await CacheManger.instance
        .cacheFirst<PaginationData<Doctor>>(
          getLocal: () => localDataSource.getDoctors(request),
          forceRefresh: forceRefresh,
          onError: (_) => PaginationData<Doctor>.empty(),
          getRemote: () => remoteDataSource.getDoctors(request),
          saveLocal: (p) => localDataSource.saveDoctors(p.data),
          cacheMiss: (e) => e == null,
        );

    return PaginationData<DoctorEntity>(
      data: doctors.data.map((e) => e.toEntity()).toList(),
      totalCount: doctors.totalCount,
      hasMore: doctors.hasMore,
      currentPage: doctors.currentPage,
      perPage: doctors.perPage,
    );
  }

  @override
  Future<Either<AppException, DoctorDetailsEntity>> getXDoctor(
    int doctorId,
  ) async {
    final doctor = await CacheManger.instance.cacheFirst<DoctorDetails>(
      getLocal: () => localDataSource.getXDoctor(doctorId),
      getRemote: () => remoteDataSource.getXDoctor(doctorId),
      saveLocal: (d) => localDataSource.saveXDoctor(d),
      cacheMiss: (e) => e == null,
    );
    return right(doctor.toEntity());
  }
}
