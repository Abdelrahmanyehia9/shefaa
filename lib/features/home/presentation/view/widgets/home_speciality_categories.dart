part of '../home_screen.dart';

class _HomeSpecialityCategories extends StatelessWidget {
  const _HomeSpecialityCategories();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "التخصصات", action: "عرض الكل"),
        SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: UISizes.w4,
            children: List.generate(12, (_)=>const SpecialtyCategoryCard()),
          ),
        )
      ],
    );
  }
}
