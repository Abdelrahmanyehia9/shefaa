import 'package:flutter/cupertino.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';

enum NotificationType {
  appointmentConfirmed,
  appointmentUpcoming,
  appointmentCancelled,
  offer,
  payment,
  other;

  IconData get icon => switch (this) {
    appointmentConfirmed ||
    appointmentUpcoming ||
    appointmentCancelled => AppIcons.appointment,
    offer => AppIcons.offer,
    payment => AppIcons.pay,
    _ => AppIcons.notification,
  };

  Color get color => switch (this) {
    appointmentConfirmed => AppColors.success,
    appointmentCancelled => AppColors.error,
    payment => AppColors.grey,
    offer => AppColors.secondary,
    _ => AppColors.primary,
  };
}
