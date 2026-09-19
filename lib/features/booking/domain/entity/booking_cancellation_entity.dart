import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/cancel_reason_type.dart';
import 'package:shefaa/core/enum/user_role.dart';
import 'package:shefaa/core/utils/fake_data.dart';

class BookingCancellationEntity extends Equatable {
  final CancelReasonType reason;
  final UserRole cancelledBy;
  final String? extraInfo;
  final DateTime? createdAt;

  const BookingCancellationEntity(
      {required this.reason, required this.cancelledBy, required this.extraInfo, required this.createdAt});

  @override
  List<Object?> get props => [reason, cancelledBy, extraInfo, createdAt];


  static BookingCancellationEntity get mock =>
      BookingCancellationEntity(
          reason: CancelReasonType.other,
          cancelledBy: UserRole.patient,
          extraInfo: FakeData.string(12),
          createdAt: FakeData.dateTime);


}