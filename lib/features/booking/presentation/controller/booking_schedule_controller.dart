import 'package:flutter/material.dart';
import 'package:shefaa/core/models/local_time.dart';

class BookingScheduleController extends ChangeNotifier {
  DateTime? selectedDate;
  LocalTime? selectedTime;

  void selectDate(DateTime date) {
    selectedDate = date;
    selectedTime = null;
    notifyListeners();
  }

  void selectTime(LocalTime time) {
    selectedTime = time;
    notifyListeners();
  }

  void clear() {
    selectedDate = null;
    selectedTime = null;
    notifyListeners();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  DateTime toDateTime() {
    final DateTime date = selectedDate ??DateTime.now() ;
    final LocalTime time = LocalTime(hour: selectedTime?.hour??date.hour, minute: selectedTime?.minute??date.minute);
    return DateTime(date.year, date.month, date.day ,time.hour, time.minute);
  }
}