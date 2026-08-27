import 'package:shefaa/core/enum/payment_method.dart';

abstract class AppConstants {
  static const List<PaymentMethod> enabledPaymentMethods = [PaymentMethod.cash, PaymentMethod.apple];

  static const List<int> supportPay = [25, 50, 100, 150, 200];
  static const String appName = 'Base App';
  static const String apiBaseUrl = 'https://api.example.com';
  static const int cacheDurationInSeconds = 3600; // 1 hour
  static const String authTokenKey = 'auth_token';
  static const String userPreferencesKey = 'user_preferences';
}
