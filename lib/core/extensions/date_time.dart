import 'package:intl/intl.dart';
import 'package:shefaa/core/utils/time_message.dart';

extension OnDateTime on DateTime {
  String _iniTime({required String format, String? locale}) {
    /// This function is used to format the DateTime object into a string representation based on the provided format and locale.
    return DateFormat(format, locale ?? 'en').format(this);
  }

  String time12Only({String? locale}) =>
      _iniTime(format: 'hh:mm a', locale: locale);
  String toTime24Only({String? locale}) =>
      _iniTime(format: 'HH:mm', locale: locale);
  String toCurrentHour({String? locale}) =>
      _iniTime(format: 'HH', locale: locale);
  String toDateOnly({String? locale}) =>
      _iniTime(format: 'yyyy-MM-dd', locale: locale);
  String toTimeAndDate({String? locale}) =>
      _iniTime(format: 'yyyy-MM-dd hh:mm a', locale: locale);
  String toCurrent({String? locale}) =>
      _iniTime(format: 'yyyy-MM-dd hh:mm:ss', locale: locale);
  String toMonthAndDay({String? locale}) =>
      _iniTime(format: 'dd MM', locale: locale);
  String toYearMonthDay({String? locale}) =>
      _iniTime(format: 'dd MMM yyyy', locale: locale);
  String toBirthDateForm({String? locale}) =>
      _iniTime(format: 'dd/MM/yyyy', locale: locale);
  String toNameOfDayAndMonth({String? locale}) =>
      _iniTime(format: 'EEEE, MMM dd', locale: locale);
  String toNameOfMonthAndTime({String? locale}) =>
      _iniTime(format: 'MMM dd hh:mm a', locale: locale);
  String toNameOfDayMonthYearTime({String? locale}) =>
      _iniTime(format: 'E d MMM yyyy hh:mm aaa', locale: locale);

  int get toTimeStamp => millisecondsSinceEpoch;
  int get toTimeStampForHours =>
      DateTime(year, 0, 0, hour, minute, second).millisecondsSinceEpoch;

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool get isPast => isBefore(DateTime.now());
  bool get isFuture => isAfter(DateTime.now());

  String timeAgo({TimeMessages messages = const TimeMessagesEn()}) {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60) return messages.justNow;
    if (diff.inMinutes < 60) return messages.minutes(diff.inMinutes);
    if (diff.inHours < 24) return messages.hours(diff.inHours);
    if (diff.inDays < 7) return messages.days(diff.inDays);
    if (diff.inDays < 30) return messages.weeks((diff.inDays / 7).floor());
    if (diff.inDays < 365) return messages.months((diff.inDays / 30).floor());
    return messages.years((diff.inDays / 365).floor());
  }

  String timeAfter({TimeMessages messages = const TimeMessagesEn()}) {
    final diff = difference(DateTime.now());
    if (diff.inSeconds < 60) return messages.justNow;
    if (diff.inMinutes < 60) return messages.minutes(diff.inMinutes);
    if (diff.inHours < 24) return messages.hours(diff.inHours);
    if (diff.inDays < 7) return messages.days(diff.inDays);
    if (diff.inDays < 30) return messages.weeks((diff.inDays / 7).floor());
    if (diff.inDays < 365) return messages.months((diff.inDays / 30).floor());
    return messages.years((diff.inDays / 365).floor());
  }
}
