enum PaymentMethod {
  cash,
  apple,
  card;

  String get text => switch (this) {
    cash => "كاش فى العيادة",
    apple => "ابل باى",
    card => "كارت البنك",
  };
}
