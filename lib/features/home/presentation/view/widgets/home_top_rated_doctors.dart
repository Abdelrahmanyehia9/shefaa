part of "../home_screen.dart";

class _HomeTopRatedDoctors extends StatelessWidget {
  const _HomeTopRatedDoctors();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(title: "أفضل المتخصصين", action: "عرض الكل",),
        DoctorList(shrinkWrap: true,)
      ],
    );
  }
}
