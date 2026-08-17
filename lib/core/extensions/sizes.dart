import 'package:flutter/material.dart';

extension SizesExt on BuildContext {
  double get safeTopArea => MediaQuery.of(this).padding.top;
  double get safeBottomArea => MediaQuery.of(this).padding.bottom;
  double get safeLeftArea => MediaQuery.of(this).padding.left;
  double get safeRightArea => MediaQuery.of(this).padding.right;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get screenSize => width / height;
}
