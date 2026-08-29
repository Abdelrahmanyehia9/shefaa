import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/shared/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/home/domain/usecase/get_home_nearby_clinic_use_case.dart';

class GetHomeNearbyClinicCubit extends Cubit<BaseState<List<ClinicEntity>>>{
  final GetHomeNearbyClinicUseCase _useCase ;
  GetHomeNearbyClinicCubit(this._useCase):super(const .initial()) ;


  Future<void>getNearbyClinics({bool forceRefresh = false})async{
    safeEmit(const .loading());
    final clinics = await _useCase.call(forceRefresh)  ;
    if(clinics.isEmpty) return safeEmit(const .empty()) ;
    safeEmit(.success(clinics)) ;
  }
}