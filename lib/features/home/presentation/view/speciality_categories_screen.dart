import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/enum/speciality_tags.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/presentation/controllers/local_search_cubit.dart';
import 'package:shefaa/shared/presentation/view/layout/speciality_categories_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/search_field.dart';
import 'package:shefaa/shared/presentation/view/widgets/local_search_builder.dart';

class SpecialityCategoriesScreen extends StatelessWidget {
  const SpecialityCategoriesScreen({
    super.key,
    required this.specialities,
  });

  final List<SpecialityEntity> specialities;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocalSearchCubit<SpecialityEntity>>();

    return AppScaffold(
      appBar: AppBar(
        title: const AppText("التخصصات"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: UISizes.h16),
        child: Column(
          spacing: UISizes.h12,
          children: [
            SearchField(
          height: UISizes.h48,
          hint: "ابحث فى تخصصات",
          onChange: cubit.search,
        ),
            LocalSearchBuilder<SpecialityEntity>(
              onSearch: (_) {},
              onInit: (context, items) {
                final popular = items
                    .where(
                      (e) => e.tags.contains(SpecialityTags.popular),
                ).toList();
                return Column(
                  children: [
                    if (popular.isNotEmpty)
                      _Section(title:  "اشهر التخصصات",items: popular),
                    _Section(title: "جميع التخصصات", items : items),
                  ],
                );
              },
              onFiltered: (context, filtered, query) => _Section(
                title: 'نتائج البحث لـ "$query"',
                items:filtered,
              ),
              onEmpty: (context, query) => AppText(
                'لا توجد نتائج مطابقة لـ "$query"',
              ).appPaddingAll(32),
            ),
          ],
        ),
      ),
    );
  }

}


class _Section extends StatelessWidget {
  final String title  ;
  final List<SpecialityEntity> items;
  const _Section({required  this.title, required this.items});
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
      SectionHeader.smallHeader(
      title,
      paddingVr: UISizes.h8,
      style: context.textTheme.labelMedium?.copyWith(
        color: context.colors.surfaceContainerLow,
      ),
    ),
        SpecialityCategoriesList(
          axis: Axis.vertical,
          specialities: items,
          shrinkWrap: true,
        ),
      ],
    );
  }
}
