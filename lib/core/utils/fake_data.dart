class FakeData {
  const FakeData._();

  static String string([int count = 1]) => 'Mock' * count;
  static const int integer = 1;
  static const double decimal = 1.0;
  static const bool boolean = true;
  static final DateTime dateTime = DateTime(2024);

  static List<T> list<T>(T value, {int length = 7}) =>
      List.filled(length, value);
}
