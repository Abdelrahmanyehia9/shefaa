import 'package:shefaa/core/enum/cancel_reason_type.dart';
import 'package:shefaa/core/enum/user_role.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/features/booking/domain/entity/booking_cancellation_entity.dart';

class BookingCancellation {
  final CancelReasonType reason;
  final UserRole cancelledBy;
  final String? extraInfo;
  final DateTime? createdAt;

  BookingCancellation({
    required this.reason,
    required this.cancelledBy,
    this.extraInfo,
    this.createdAt,
  });

  factory BookingCancellation.fromJson(Map<String, dynamic> json) =>
      BookingCancellation(
        reason:
        enumFromJson(json['reason'], CancelReasonType.values) ??
            CancelReasonType.other,
        cancelledBy:
        enumFromJson(json['cancelled_by'], UserRole.values) ??
            UserRole.patient,
        extraInfo: json['extra_info'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
      );


  Map<String, dynamic> toJson() =>
      {
        "reason": reason.name,
        "cancelled_by": cancelledBy.name,
        "extra_info": extraInfo,
        "created_at": (createdAt ?? DateTime.now()).toIso8601String()
      };

  BookingCancellationEntity toEntity() =>
      BookingCancellationEntity(
          reason: reason,
          cancelledBy: cancelledBy,
          extraInfo: extraInfo,
          createdAt: createdAt);
}
