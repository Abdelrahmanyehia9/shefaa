part of "../home_screen.dart";

class _HomeNearbyClinic extends StatelessWidget {
  const _HomeNearbyClinic();

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<GetHomeNearbyClinicCubit, List<ClinicEntity>>(
      successBuilder:(clinics)=> _builder(clinics, context), 
      loadingBuilder: ()=>_builder(ClinicEntity.mock.fakeList(4), context),
    );
  }

  Widget _builder(List<ClinicEntity>clinics, BuildContext context)=>Column(
    children: [
      SectionHeader(
        title: "العيادات القريبة",
        action: "عرض الكل",
        onAction: () => context.pushNamed(Routes.clinics, arguments: context.read<GetSpecialitiesCubit>()),
      ),
       ClinicList(clinics: clinics,),
    ],
  );
}
