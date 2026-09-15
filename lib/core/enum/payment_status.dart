enum PaymentStatus {
  pending,
  completed,
  cancelled;

  String get text => switch (this) {
    pending => "معلق",
    completed => "المكتملة",
    cancelled => "الملغية",
  };

  bool get isPending => this == pending;
  bool get isCompleted => this == completed;
  bool get iCancelled => this == cancelled;
}
