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
          onAction: () => context.pushNamed(Routes.doctors, arguments: context.read<GetSpecialitiesCubit>()),
        ),
        const DoctorList(shrinkWrap: true),
      ],
    );
  }
}
