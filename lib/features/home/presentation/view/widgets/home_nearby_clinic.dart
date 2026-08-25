part of "../home_screen.dart";

class _HomeNearbyClinic extends StatelessWidget {
  const _HomeNearbyClinic();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: "العيادات القريبة",
          action: "عرض الكل",
          onAction: () => context.pushNamed(Routes.clinics),
        ),
        const ClinicList(),
      ],
    );
  }
}
