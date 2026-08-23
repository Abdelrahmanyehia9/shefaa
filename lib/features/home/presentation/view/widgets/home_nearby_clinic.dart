part of "../home_screen.dart" ;
class _HomeNearbyClinic extends StatelessWidget {
  const _HomeNearbyClinic();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(title: "العيادات القريبة", action: "عرض الكل",),
        ClinicList()
      ],
    );
  }
}
