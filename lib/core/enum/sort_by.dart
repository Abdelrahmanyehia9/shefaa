enum SortBy { nearby, newest, rating, price ;

  String get text => switch(this){
    nearby => "المسافة",
    newest => "الاحدث",
    rating=> "القييم",
    price => "السعر"
  };

}
