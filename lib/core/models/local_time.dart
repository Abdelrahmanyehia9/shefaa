class LocalTime {
  final int hour;
  final int minute;

  const LocalTime({required this.hour, required this.minute});

  factory LocalTime.fromJson(Map<String, dynamic> json) {
    return LocalTime(hour: json['hour'] as int, minute: json['minute'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'hour': hour, 'minute': minute};
  }
}
