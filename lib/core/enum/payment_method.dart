import 'package:shefaa/features/booking/domain/strategy/payment_cash_strategy.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';

enum PaymentMethod {
  cash,
  apple,
  card;

  String get text => switch (this) {
    cash => "كاش فى العيادة",
    apple => "ابل باى",
    card => "كارت البنك",
  };


  PaymentStrategy toStrategy() => PaymentCashStrategy();
}
