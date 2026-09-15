import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/core/utils/fake_data.dart';

class PaymentEntity extends Equatable {
  final int id;
  final DateTime? createdAt;
  final String? transactionId;
  final PaymentMethod method;
  final num amount;
  final num supportAmount;

  const PaymentEntity({
    required this.id,
    required this.createdAt,
    required this.transactionId,
    required this.method,
    required this.amount,
    required this.supportAmount,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, transactionId];

  static PaymentEntity get mock => PaymentEntity(
    id: FakeData.integer,
    createdAt: FakeData.dateTime,
    transactionId: FakeData.string(),
    method: PaymentMethod.cash,
    amount: FakeData.integer,
    supportAmount: FakeData.decimal,
  );
}
