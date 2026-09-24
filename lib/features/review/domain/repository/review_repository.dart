import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/review/data/models/review_request.dart';
import 'package:shefaa/features/review/domain/entity/review_entity.dart';

abstract interface class ReviewRepository {
  Future<Either<AppException, ReviewEntity>>reviewDoctor({required ReviewRequest request, required int docId});
  Future<Either<AppException, ReviewEntity>>reviewClinic({required ReviewRequest request, required int clinicId});
  Future<Either<AppException, ReviewEntity>>reviewStaff({required ReviewRequest request, required int docId});
}