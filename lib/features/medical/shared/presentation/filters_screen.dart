import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/enum/docotor_level.dart';
import 'package:shefaa/core/enum/filter_type.dart';
import 'package:shefaa/core/enum/sort_by.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/medical/shared/data/models/filters.dart';
import 'package:shefaa/features/medical/shared/data/models/filters_info.dart';
import 'package:shefaa/features/medical/shared/presentation/controller/filters_cubit.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/filter_tile.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/filters_config.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/category_svg.dart';

final class FilterScreenArgs {
  final FiltersInfo allFilters;
  final Filters? initialFilters;
  const FilterScreenArgs({required this.allFilters, this.initialFilters});
}

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FiltersCubit>();
    return AppScaffold(
      appBar: AppBar(
        title: const AppText("التصفيات"),
        actions: [
          AppClick(
            onTap: cubit.resetToDefaults,
            child: AppText(
              "مسح المرشحات",
              style: context.textTheme.titleSmall,
              color: context.colors.primary,
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: BlocBuilder<FiltersCubit, FiltersStates>(
        builder: (context, state) {
          if (state is FiltersStatesLoaded) {
            final configs = _buildFilters(
              context,
              cubit,
              state.info,
              state.filters,
            );
            return Column(
              spacing: UISizes.h16,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: UISizes.h12,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        configs.length,
                        (i) => FilterTile(
                          config: configs[i],
                          initiallyExpanded: i != 0,
                        ),
                      ),
                    ),
                  ),
                ),
                AppButton.filled(
                  "تاكيد التصفيات",
                  onTap: () => context.pop(state.filters),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  List<FilterConfig> _buildFilters(
    BuildContext context,
    FiltersCubit cubit,
    FiltersInfo info,
    Filters filters,
  ) {
    return [
      if (!info.specialities.isNullOrEmpty)
        MultiSelectFilterConfig<SpecialityEntity>(
          title: FilterType.speciality.title,
          optionLabelBuilder: (s) => s.title,
          value: filters.specialities ?? [],
          options: info.specialities!,
          subtitleBuilder: (s) =>
              s.isNullOrEmpty ? "اى " : s.filterLabel(count: 4),
          labelBuilder: (s, isSelected) => AppIconText(
            expandedText: true,
            customIcon: CategorySVG(
              url: s.icon,
              color: context.colors.surfaceContainerHighest,
              size: UISizes.sp20,
            ),
            text: s.title,
            textStyle: context.textTheme.labelMedium,
          ),
          onChanged: cubit.updateSpecialities,
        ),
      RadioFilterConfig<int>(
        title: FilterType.rating.title,
        value: filters.rating,
        options: info.ratingsStars ?? const [1, 2, 3, 4],
        subtitleBuilder: (v) => v == null ? "اختار التقييم" : "$v فيما اكثر",
        itemBuilder: (val) => AppIconText(
          icon: AppIcons.starFilled,
          iconColor: AppColors.gold,
          text: "$val فيما اكثر",
          textStyle: context.textTheme.labelMedium,
        ),
        onChanged: cubit.updateRating,
        defaultSubtitle: "اى تقييم",
      ),
      if (info.priceBounds != null)
        RangeFilterConfig(
          title: FilterType.price.title,
          value: filters.price ?? info.priceBounds!,
          bounds: info.priceBounds!,
          unitLabelBuilder: (v) => "${v.toInt()} جنيه",
          onChanged: cubit.updatePrice,
        ),
      SliderFilterConfig(
        title: FilterType.distance.title,
        value: filters.distance ?? info.distanceBounds.end * .3,
        min: info.distanceBounds.start,
        max: info.distanceBounds.end,
        unitLabelBuilder: (v) => v < 1
            ? "${(v * 1000).toInt()} متر"
            : "${v.toStringAsFixed(1)}  كيلومتر",
        onChanged: cubit.updateDistance,
      ),
      if (info.doctorLevels != null)
        MultiSelectFilterConfig<DoctorLevel>(
          title: FilterType.doctorLevel.title,
          optionLabelBuilder: (s) => s.text,
          value: filters.levels ?? [],
          options: info.doctorLevels!,
          labelBuilder: (l, _) => AppText(l.text),
          onChanged: cubit.updateLevels,
        ),
      RadioFilterConfig<SortBy>(
        title: FilterType.sortBy.title,
        value: filters.sortBy,
        subtitleBuilder: (v) => v?.text ?? "الافتراضي",
        options: info.sorts,
        itemBuilder: (val) =>
            AppText(val.text, style: context.textTheme.labelMedium),
        onChanged: cubit.updateSortBy,
      ),
    ];
  }
}
