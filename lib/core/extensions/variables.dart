import 'package:shefaa/core/utils/number_messages.dart';

/// String ///
extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || (this?.trim().isEmpty ?? true);
}

/// List ////
extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

/// Number ///

extension NumberFormatter on num {
  String get compactNumber {
    if (this >= 1000000000) {
      return "${(this / 1000000000).toStringAsFixed(1)}${NumberMessages.billionAbbr}";
    }

    if (this >= 1000000) {
      return "${(this / 1000000).toStringAsFixed(1)}${NumberMessages.millionAbbr}";
    }

    if (this >= 1000) {
      return "${(this / 1000).toStringAsFixed(1)}${NumberMessages.thousandAbbr}";
    }

    return toStringAsFixed(0);
  }
}

/// Map ///
extension MapEXT on Map<String, dynamic> {
  Map<String, dynamic> withoutNulls() {
    return Map.fromEntries(entries.where((e) => e.value != null));
  }
}

extension MapDynamicEXT on Map {
  Map<String, dynamic> get deepCast {
    return map((key, value) {
      if (value is Map) return MapEntry(key.toString(), value.deepCast);
      if (value is List) {
        return MapEntry(
          key.toString(),
          value.map((e) => e is Map ? e.deepCast : e).toList(),
        );
      }
      return MapEntry(key.toString(), value);
    });
  }
}
