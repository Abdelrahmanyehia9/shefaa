import 'package:shefaa/core/helper/cache_manger.dart';
import 'package:shefaa/shared/data/datasource/speciality_local_data_source.dart';
import 'package:shefaa/shared/data/datasource/speciality_remote_data_source.dart';
import 'package:shefaa/shared/data/models/speciality.dart';
import 'package:shefaa/shared/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/domain/repository/speciality_repository.dart';

class SpecialityRepositoryImpl implements SpecialityRepository {
  final SpecialityRemoteDataSource remoteDataSource;
  final SpecialityLocalDataSource localDataSource;

  SpecialityRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<SpecialityEntity>> getSpecialities({bool forceRefresh= false}) async {
    final List<Speciality> specialities = await CacheManger.instance
        .cacheFirst<List<Speciality>>(
          getLocal: localDataSource.getSpecialities,
          forceRefresh: forceRefresh,
          getRemote: remoteDataSource.getSpeciality,
          saveLocal: localDataSource.saveSpecialities,
          onError: (_) => <Speciality>[],
          cacheMiss: (e) => e == null,
        );
    final entities = specialities.map((e) => e.toEntity()).toList();
    return entities;
  }
}
