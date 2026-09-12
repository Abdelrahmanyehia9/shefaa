import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';


class PaymentCashStrategy implements PaymentStrategy{
  @override
  PaymentMethod get method => PaymentMethod.cash;

  @override
  Future<void> pay({required num amount}) async{
   return;
  }



}