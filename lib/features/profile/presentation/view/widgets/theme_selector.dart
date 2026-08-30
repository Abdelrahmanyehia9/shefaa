import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/selector_bottom_sheet.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/shared/presentation/controllers/user_theme_cubit.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserThemeCubit>();
    final cubitTheme = cubit.state.data ?? ThemeMode.system;
    return SelectorBottomSheet(
      title: "اختار السمة ",
      onItemTap: (item) {
        final theme = item as ThemeMode?;
        if (theme != cubitTheme && theme != null) {
          cubit.toggleThemeMode(theme);
        }
      },
      itemTextStyle: context.textTheme.titleMedium,
      selectedTextColor: context.colors.onPrimary,
      selectedColor: context.colors.primary,
      titleStyle: context.textTheme.headlineSmall,
      data: ThemeMode.values
          .map(
            (e) => SelectorBottomSheetData<ThemeMode>(
              title: e.text,
              leading: (selected) => Icon(
                e.icon,
                color: selected ? context.colors.onPrimary : null,
              ),
              selected: e == cubitTheme,
              id: e,
            ),
          )
          .toList(),
    );
  }
}
