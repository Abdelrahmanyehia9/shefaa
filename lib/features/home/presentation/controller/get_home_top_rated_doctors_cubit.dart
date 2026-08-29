import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/home/domain/usecase/get_home_top_rated_doctors_use_case.dart';
import 'package:shefaa/shared/domain/entity/doctor_entity.dart';

class GetHomeTopRatedDoctorsCubit extends Cubit<BaseState<List<DoctorEntity>>>{
  final GetHomeTopRatedDoctorsUseCase _useCase ;
  GetHomeTopRatedDoctorsCubit(this._useCase):super(const .initial()) ;


  Future<void>getTopRatedDoctors({bool forceRefresh = false})async{
    safeEmit(const .loading());
    final doctors = await _useCase.call(forceRefresh)  ;
    if(doctors.isEmpty) return safeEmit(const .empty()) ;
    safeEmit(.success(doctors)) ;
  }
}