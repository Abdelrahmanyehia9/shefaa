import 'dart:io';

import 'package:shefaa/core/extensions/variables.dart';

class ReviewRequest {
  final double? rating;
  final String? comment;
  final List<File>? media;

  const ReviewRequest({
    required this.rating,
    required this.comment,
     this.media,
  });


  Map<String , dynamic>toJson()=>{
    "rate":rating,
    "comment": comment ,
  }
  .withoutNulls() ;
}
