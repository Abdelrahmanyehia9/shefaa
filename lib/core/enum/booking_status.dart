import 'dart:ui';

import 'package:shefaa/core/utils/app_colors.dart';

enum BookingStatus {
  upcoming,
  completed,
  cancelled;

  String get text => switch (this) {
    upcoming => "القادمة",
    completed => "المكتملة",
    cancelled => "الملغية",
  };

  Color get color => switch (this) {
    upcoming => AppColors.grey,
    completed => AppColors.success,
    cancelled => AppColors.error,
  };
  bool get isUpcoming => this == upcoming;
  bool get isCompleted => this == completed;
  bool get iCancelled => this == cancelled;
}
