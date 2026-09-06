import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/shared/data/models/user_model.dart';

class BookingRequest {
  final int doctorId;
  final int? clinicId;
  final DateTime bookingDate;
  final UserModel? customUser;
  final num amount;
  final PaymentMethod paymentMethod;
  final num supportUsAmount;

  const BookingRequest({
    required this.doctorId,
     this.clinicId,
    required this.bookingDate,
    this.customUser,
    required this.amount,
    required this.paymentMethod,
    this.supportUsAmount = 0 ,
  });


  Map<String , dynamic>toJson()=>{
    'doctor_id':doctorId,
    'clinic_id': clinicId,
    'date': bookingDate.toIso8601String(),
    'custom_user':customUser?.toJson(),
    'amount':amount,
    'payment_method':paymentMethod.toJson(),
    'support_us_amount':supportUsAmount
  };
  BookingRequest copyWith({
    int? doctorId,
    int? clinicId,
    DateTime? bookingDate,
    UserModel? customUser,
    num? amount,
    PaymentMethod? paymentMethod,
    num? supportUsAmount,
  }) {
    return BookingRequest(
      doctorId: doctorId ?? this.doctorId,
      clinicId: clinicId ?? this.clinicId,
      bookingDate: bookingDate ?? this.bookingDate,
      customUser: customUser ?? this.customUser,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      supportUsAmount: supportUsAmount ?? this.supportUsAmount,
    );
  }

}
