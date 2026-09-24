import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/app_exception.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/review/data/datasource/review_remote_data_source.dart';
import 'package:shefaa/features/review/data/models/review_request.dart';
import 'package:shefaa/features/review/domain/entity/review_entity.dart';
import 'package:shefaa/features/review/domain/repository/review_repository.dart';

class ReviewsRepositoryImpl implements ReviewRepository{
  final ReviewRemoteDataSource remoteDataSource ;
  ReviewsRepositoryImpl({required this.remoteDataSource}) ;

  @override
  Future<Either<AppException, ReviewEntity>> reviewClinic({required ReviewRequest request, required int clinicId}) async{
     try{
       final rate = await remoteDataSource.reviewClinic(request: request, clinicId: clinicId) ;
       return right(rate.toEntity()) ;
     }catch(e){
       return left(e.toAppException());
     }
  }

  @override
  Future<Either<AppException, ReviewEntity>> reviewDoctor({required ReviewRequest request, required int docId}) async{
    try{
      final rate = await remoteDataSource.reviewDoctor(request: request, doctorId: docId) ;
      return right(rate.toEntity()) ;
    }catch(e){
      return left(e.toAppException());
    }
  }

  @override
  Future<Either<AppException, ReviewEntity>> reviewStaff({required ReviewRequest request, required int docId}) async{
    try{
      final rate = await remoteDataSource.reviewStaff(request: request, doctorId: docId) ;
      return right(rate.toEntity()) ;
    }catch(e){
      return left(e.toAppException());
    }
  }


}