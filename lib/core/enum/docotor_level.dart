enum DoctorLevel {
  specialist,
  consultant,
  professor;

  String get text => switch (this) {
    DoctorLevel.specialist => 'أخصائي',
    DoctorLevel.consultant => 'استشاري',
    DoctorLevel.professor => 'أستاذ',
  };
}