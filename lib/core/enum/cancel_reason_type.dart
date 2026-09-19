enum CancelReasonType {
  weatherCondition,
  unexpectedWork,
  childrenIssues,
  travelDelay,
  priceExpensive,
  foundBetterDoctor,
  other,
}

extension CancelReasonTypeX on CancelReasonType {
  String get text => switch (this) {
    CancelReasonType.weatherCondition => 'ظروف جوية',
    CancelReasonType.unexpectedWork => 'ظروف عمل طارئة',
    CancelReasonType.childrenIssues => 'مشاكل متعلقة بالأطفال',
    CancelReasonType.travelDelay => 'تأخر في السفر',
    CancelReasonType.priceExpensive => 'السعر مرتفع',
    CancelReasonType.foundBetterDoctor => ' وجدت طبيبًا أفضل فى مكان اخر',
    CancelReasonType.other => ' آخر',
  };
}