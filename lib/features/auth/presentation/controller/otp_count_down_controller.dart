import 'package:flutter/material.dart';

class OtpCountDownController {
  final ValueNotifier<int> seconds = ValueNotifier(30);
  final ValueNotifier<int> attemptsLeft = ValueNotifier(3);

  bool get isFinished => seconds.value == 0;
  bool get hasAttemptsLeft => attemptsLeft.value > 0;

  void dispose() {
    seconds.dispose();
    attemptsLeft.dispose();
  }
}
