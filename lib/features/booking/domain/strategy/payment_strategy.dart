import 'package:shefaa/core/enum/payment_method.dart';

abstract interface class PaymentStrategy {
  PaymentMethod get method;

  Future<void> pay({required num amount});
}
