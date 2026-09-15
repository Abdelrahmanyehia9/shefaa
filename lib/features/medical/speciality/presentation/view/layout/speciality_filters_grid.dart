import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_filters_grid.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/presentation/controllers/selection_cubit.dart';
import 'package:shefaa/shared/presentation/view/widgets/category_svg.dart';

class SpecialityFiltersGrid extends StatelessWidget {
  const SpecialityFiltersGrid({
    super.key,
    this.initialIndexes = const [],
    this.specialities = const [],
    this.onChanged,
  });

  final List<int> initialIndexes;
  final List<SpecialityEntity> specialities;
  final ValueChanged<List<int>>? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectionCubit<int>()..selectAll(initialIndexes),
      child: _SpecialityFiltersGridView(
        specialities: specialities,
        onChanged: onChanged,
      ),
    );
  }
}

class _SpecialityFiltersGridView extends StatelessWidget {
  const _SpecialityFiltersGridView({
    required this.specialities,
    this.onChanged,
  });

  final List<SpecialityEntity> specialities;
  final ValueChanged<List<int>>? onChanged;

  List<int> _toShownIndexes(SelectionState<int> state) {
    if (state.selected.isEmpty) return specialities.isEmpty ? [] : [0];
    return state.selected.map((i) => i + 1).toList();
  }

  void _handleChanged(BuildContext context, List<int> incomingShown) {
    final cubit = context.read<SelectionCubit<int>>();
    final newRealSelected = incomingShown
        .where((i) => i != 0)
        .map((i) => i - 1)
        .toList();

    cubit.selectAll(newRealSelected);
    onChanged?.call(newRealSelected);
  }

  @override
  Widget build(BuildContext context) {
    return SelectionBuilder<int>(
      builder: (state, cubit) {
        return AppFiltersGrid(
          multiSelection: true,
          initialIndexes: _toShownIndexes(state),
          itemCount: specialities.length + 1,
          childAspectRatio: 0.4,
          onChanged: (incoming) => _handleChanged(context, incoming),
          itemBuilder: (context, index, isSelected, isDisabled) {
            final color = isSelected
                ? AppColors.white
                : context.colors.surfaceContainerHighest;

            if (index == 0) {
              return AppIconText(
                text: 'الكل',
                color: color,
                textStyle: context.textTheme.labelLarge,
              );
            }

            final speciality = specialities[index - 1];

            return AppIconText(
              customIcon: CategorySVG(
                url: speciality.icon,
                color: color,
                size: UISizes.sp20,
              ),
              text: speciality.title,
              color: color,
              textStyle: context.textTheme.labelLarge,
            );
          },
        );
      },
    );
  }
}
