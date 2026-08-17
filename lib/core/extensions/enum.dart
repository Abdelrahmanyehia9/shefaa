import 'package:collection/collection.dart';

T? enumFromJson<T extends Enum>(
  String value,
  List<T> values, {
  Map<T, String>? metadata,
}) {
  return values.firstWhereOrNull(
    (e) => metadata?[e] == value || e.name == value,
  );
}

extension EnumJsonExtension<T extends Enum> on T {
  String toJson([Map<T, String>? metadata]) {
    return metadata?[this] ?? name;
  }
}
