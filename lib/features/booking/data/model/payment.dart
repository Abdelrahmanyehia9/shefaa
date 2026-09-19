import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/core/enum/payment_status.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/features/booking/domain/entity/payment_entity.dart';

class Payment {
  final int id;
  final DateTime? createdAt;
  final String? transactionId;
  final PaymentMethod method;
  final num amount;
  final num supportAmount;
  final PaymentStatus status ;

  const Payment({
    required this.id,
    required this.createdAt,
    required this.transactionId,
    required this.method,
    required this.amount,
    required this.supportAmount,
    required this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json['id'],
    status: enumFromJson(json['status'], PaymentStatus.values) ?? PaymentStatus.pending,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at']),
    transactionId: json['transaction_id'],
    method:
        enumFromJson(json['payment_method'], PaymentMethod.values) ??
        PaymentMethod.cash,
    amount: json['amount'],
    supportAmount: json['support_us_amount'],
  );

  PaymentEntity toEntity() => PaymentEntity(
    id: id,
    createdAt: createdAt,
    transactionId: transactionId,
    method: method,
    amount: amount,
    supportAmount: supportAmount,
    status: status
  );
}
