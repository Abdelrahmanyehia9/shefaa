import 'dart:ui';

import 'package:shefaa/core/utils/app_colors.dart';

enum PaymentStatus {
  pending,
  completed,
  cancelled;

  String get text => switch (this) {
    pending => "معلق",
    completed => "المكتملة",
    cancelled => "الملغية",
  };
  Color get color => switch (this) {
    pending => AppColors.grey,
    completed =>AppColors.success ,
    cancelled => AppColors.error,
  };

  bool get isPending => this == pending;
  bool get isCompleted => this == completed;
  bool get iCancelled => this == cancelled;



}
