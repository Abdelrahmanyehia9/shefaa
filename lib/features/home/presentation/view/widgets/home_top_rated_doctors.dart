part of "../home_screen.dart";

class _HomeTopRatedDoctors extends StatelessWidget {
  const _HomeTopRatedDoctors();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: "أفضل المتخصصين",
          action: "عرض الكل",
          onAction: () => context.pushNamed(Routes.doctors),
        ),
        const DoctorList(shrinkWrap: true),
      ],
    );
  }
}
