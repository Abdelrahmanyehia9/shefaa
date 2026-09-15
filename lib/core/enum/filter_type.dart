enum FilterType {
  speciality("التخصص"),
  rating("التقييم"),
  price("سعر الكشف"),
  distance("المسافة"),
  doctorLevel("لقب الدكتور"),
  sortBy("رتب حسب");

  final String title;

  const FilterType(this.title);
}
