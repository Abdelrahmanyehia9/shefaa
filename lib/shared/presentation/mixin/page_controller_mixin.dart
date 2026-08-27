import 'package:flutter/cupertino.dart';

mixin PageControllerMixin<T extends StatefulWidget> on State<T> {
  final PageController pageController = PageController();

  int get currentIndex;
  int get pagesLength;

  bool get isLast => currentIndex == pagesLength - 1;
  bool get isFirst => currentIndex == 0;

  void next() {
    if (isLast) {
      return onFinish();
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void prev() {
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onFinish();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
