import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shefaa/core/utils/app_icons.dart';

enum AppPermission {
  location , gallery ,camera , notification ;


  Permission toPermission(){
    switch(this){
      case location :
        return Permission.location ;
      case gallery :
        return Permission.photos ;
      case camera :
        return Permission.camera ;
      case notification :
        return Permission.notification ;
    }
  }

  IconData get icon => switch(this){
    location => AppIcons.locationAccess ,
    gallery => AppIcons.photo,
   camera => AppIcons.camera ,
  notification => AppIcons.notification
  } ;

  String get text => switch(this){
    location => "الموقع" ,
    gallery => "معرض الصصور",
   camera => "الكاميرا" ,
  notification => "الاشعارات"
  } ;


  String get reason => switch (this) {
    location => "نحتاج إلى معرفة موقعك لنقترح عليك الخدمات القريبة.",
    gallery => "نحتاج إلى الوصول إلى معرض الصور لتتمكن من اختيار الصور من جهازك.",
    camera => "نحتاج إلى استخدام الكاميرا لتتمكن من التقاط الصور مباشرة.",
    notification => "نحتاج إلى إرسال الإشعارات لإبلاغك بالتحديثات والتنبيهات المهمة.",
  };
}