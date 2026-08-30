import 'package:flutter/material.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/shared/presentation/controllers/user_theme_cubit.dart';

class ThemeBuilder extends StatelessWidget {
  final Widget Function(ThemeMode) builder;
  const ThemeBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<UserThemeCubit, ThemeMode>(
      builder: (state) => builder.call(state.data ?? ThemeMode.system),
    );
  }
}
