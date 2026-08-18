import 'package:flutter/material.dart';
import 'package:shefaa/core/utils/app_icons.dart';

enum Gender {
  male,
  female;

  String get text => switch (this) {
    male => "ذكر",
    female => "انثى",
  };

  IconData get icon => switch (this) {
    male => AppIcons.male,
    female => AppIcons.female,
  };
}
