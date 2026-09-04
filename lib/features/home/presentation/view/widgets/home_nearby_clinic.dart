part of "../home_screen.dart";

class _HomeNearbyClinic extends StatelessWidget {
  const _HomeNearbyClinic();

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<GetHomeNearbyClinicCubit, List<ClinicEntity>>(
      successBuilder: (clinics) => _builder(clinics, context, hero: true),
      loadingBuilder: () => _builder(ClinicEntity.mock.fakeList(4), context),
    );
  }

  Widget _builder(List<ClinicEntity> clinics, BuildContext context, {bool hero =false}) => Column(
    children: [
      SectionHeader(
        title: "العيادات القريبة",
        action: "عرض الكل",
        onAction: () => context.pushNamed(
            Routes.medical,
            arguments: MedicalScreenArgs(specialitiesCubit: context.read<GetSpecialitiesCubit>(), type: MedicalType.clinic)
        ),
      ),
      ClinicList(clinics: clinics,heroEnabled: hero,),
    ],
  );
}
