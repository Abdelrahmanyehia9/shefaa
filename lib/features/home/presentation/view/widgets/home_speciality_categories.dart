part of '../home_screen.dart';

class _HomeSpecialityCategories extends StatelessWidget {
  const _HomeSpecialityCategories();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "التخصصات",
          action: "عرض الكل",
          onAction: () => context.pushNamed(Routes.specialityCategories),
        ),
        const SpecialityCategoriesList(),
      ],
    );
  }
}
