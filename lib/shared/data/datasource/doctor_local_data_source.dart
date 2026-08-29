import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/shared/data/models/doctor.dart';
import 'package:shefaa/shared/data/models/doctor_request.dart';

class DoctorLocalDataSource {


  Future<PaginationData<Doctor>?>getDoctors(DoctorRequest request)async{
    return null ;
  }

  Future<void>saveDoctors(List<Doctor>doctors)async{
    return ;
  }




}