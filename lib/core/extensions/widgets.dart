import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shefaa/core/components/gap.dart';

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
  Widget get spaceVr => VGap(toDouble());

  Widget get spaceHr => HGap(toDouble());
}

extension PageControllerExt on PageController {
  int get index => (hasClients && page != null) ? page!.round() : 0;

  bool isFullVisible(int i) {
    double page = index.toDouble();
    if (position.haveDimensions) {
      page = this.page ?? index.toDouble();
    }
    final isFullyVisible = (page - i).abs() < 0.01;
    return isFullyVisible;
  }

  bool isHalfVisible(int i) {
    double page = index.toDouble();
    if (position.haveDimensions) {
      page = this.page ?? index.toDouble();
    }
    final isFullyVisible = (page - i).abs() < 0.4;
    return isFullyVisible;
  }
}
