import 'package:shefaa/core/helper/cache_manger.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/clinic/data/datasource/clinic_local_data_source.dart';
import 'package:shefaa/features/clinic/data/datasource/clinic_remote_data_source.dart';
import 'package:shefaa/features/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/clinic/domain/repository/clinic_repository.dart';
import 'package:shefaa/features/clinic/data/models/clinic.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  final ClinicRemoteDataSource remoteDataSource;
  final ClinicLocalDataSource localDataSource;

  const ClinicRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<PaginationData<ClinicEntity>> getClinics(
    ClinicRequest request, {
    bool forceRefresh = false,
  }) async {
    final clinics = await CacheManger.instance
        .cacheFirst<PaginationData<Clinic>>(
          getLocal: () => localDataSource.getClinics(request),
          forceRefresh: forceRefresh,
          onError: (_) => PaginationData<Clinic>.empty(),
          getRemote: () => remoteDataSource.getClinics(request),
          saveLocal: (p) => localDataSource.saveClinics(p.data),
          cacheMiss: (e) => e == null,
        );

    return PaginationData<ClinicEntity>(
      data: clinics.data.map((e) => e.toEntity()).toList(),
      totalCount: clinics.totalCount,
      hasMore: clinics.hasMore,
      currentPage: clinics.currentPage,
      perPage: clinics.perPage,
    );
  }
}
