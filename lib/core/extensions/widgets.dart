import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension PaddingExt on Widget {
  Widget appPaddingHr([double padding = 16]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding.w),
      child: this,
    );
  }

  Widget appPaddingVr([double padding = 16]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding.h),
      child: this,
    );
  }

  Widget appPaddingAll([double padding = 16]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding.w, vertical: padding.h),
      child: this,
    );
  }

  Widget get paddingAll => appPaddingAll();

  Widget get paddingHr => appPaddingHr();

  Widget get paddingVr => appPaddingVr();
}

extension SpaceExt on num {
  Widget get spaceVr => SizedBox(height: toDouble().h);

  Widget get spaceHr => SizedBox(width: toDouble().w);
}
