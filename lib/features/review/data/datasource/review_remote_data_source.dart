import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/features/review/data/models/review.dart';
import 'package:shefaa/features/review/data/models/review_request.dart';

class ReviewRemoteDataSource {
  final SupabaseService _supabaseService;

  const ReviewRemoteDataSource(this._supabaseService);

  static const _doctor = "DoctorReviews";
  static const _clinic = "ClinicReviews";
  static const _staff = "StaffReviews";


  Future<Review> reviewDoctor({
    required ReviewRequest request,
    required int doctorId,
  }) =>
      _review(
        table: _doctor,
        idKey: "doctor_id",
        id: doctorId,
        request: request,
      );

  Future<Review> reviewStaff({
    required ReviewRequest request,
    required int doctorId,
  }) =>
      _review(
        table: _staff,
        idKey: "doctor_id",
        id: doctorId,
        request: request,
      );

  Future<Review> reviewClinic({
    required ReviewRequest request,
    required int clinicId,
  }) =>
      _review(
        table: _clinic,
        idKey: "clinic_id",
        id: clinicId,
        request: request,
      );

  Future<Review> _review({
    required String table,
    required String idKey,
    required int id,
    required ReviewRequest request,
  }) async {
    final response = await _supabaseService.INSERT(
      select: "*,Users(*)",
      table: table,
      data: {
        idKey: id,
        ...request.toJson(),
      },
    );

    return Review.fromJson(response);
  }

}
