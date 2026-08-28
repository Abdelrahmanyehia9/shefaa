part of '../home_screen.dart';

class _HomeSpecialityCategories extends StatelessWidget {
  const _HomeSpecialityCategories();

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<GetSpecialitiesCubit, List<SpecialityEntity>>(
      successBuilder: (spec) => _builder(spec, context),
      loadingBuilder: () =>
          _builder(SpecialityEntity.mock.fakeList(8), context),
    );
  }

  Widget _builder(List<SpecialityEntity> specialities, BuildContext context) {
    final popular = specialities
        .where((e) => e.tags.contains(SpecialityTags.popular))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "التخصصات",
          action: "عرض الكل",
          onAction: () => context.pushNamed(
            Routes.specialityCategories,
            arguments: specialities,
          ),
        ),
        SpecialityCategoriesList(specialities: popular),
      ],
    );
  }
}
