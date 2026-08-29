enum Weekday {
  saturday,
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday;

  String get text => switch (this) {
    saturday => "السبت",
    sunday => "الأحد",
    monday => "الاثنين",
    tuesday => "الثلاثاء",
    wednesday => "الأربعاء",
    thursday => "الخميس",
    friday => "الجمعة",
  };
}