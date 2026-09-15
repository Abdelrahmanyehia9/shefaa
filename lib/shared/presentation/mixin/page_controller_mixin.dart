import 'package:flutter/material.dart';

mixin PageControllerMixin<T extends StatefulWidget> on State<T> {
  final pageController = PageController();

  int get currentIndex;
  int get pagesLength;

  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex == pagesLength - 1;

  void next() {
    if (isLast) return onFinish();

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void prev() {
    if (isFirst) return;

    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onFinish();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
