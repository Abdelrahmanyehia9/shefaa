enum BookingStatus {
  upcoming,
  completed,
  cancelled;

  String get text => switch (this) {
    upcoming => "القادمة",
    completed => "المكتملة",
    cancelled => "الملغية",
  };

  bool get isUpcoming => this == upcoming;
  bool get isCompleted => this == completed;
  bool get iCancelled => this == cancelled;
}
