enum FavoriteType {
  doctor,
  clinic;

  String get text => switch (this) {
    doctor => "الاطباء",
    clinic => "العيادات",
  };
}
