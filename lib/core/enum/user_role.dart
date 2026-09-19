enum UserRole { patient, doctor ;

String get text => switch(this){
  doctor => "دكتور",
  patient => "مستخدم"
};
String get appName => switch(this){
  doctor => "الاطباء",
  patient => "المستخدمين"
};


}
