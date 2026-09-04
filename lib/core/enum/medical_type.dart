enum MedicalType {
  doctor,
  clinic;

  String get text => switch (this) {
    doctor => "الاطباء",
    clinic => "العيادات",
  };

  static List<MedicalType> favorite = [doctor, clinic] ;
}
