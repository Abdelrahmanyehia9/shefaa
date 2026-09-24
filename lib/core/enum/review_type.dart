enum ReviewType {
  doctor, clinic, staff;

  String get text =>switch (this){
    doctor => "الطبيب"  ,
    clinic => "العيادة",
    staff => "المساعدين"
  };
}