part of "../home_screen.dart";

class _HomeTopRatedDoctors extends StatelessWidget {
  const _HomeTopRatedDoctors();

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<GetHomeTopRatedDoctorsCubit, List<DoctorEntity>>(
      successBuilder: (d) => _builder(context, doctors: d, hero: true),
      loadingBuilder: () =>
          _builder(context, doctors: DoctorEntity.mock.fakeList(4)),
    );
  }

  Widget _builder(
    BuildContext context, {
    required List<DoctorEntity> doctors,
    bool hero = false,
  }) {
    return Column(
      children: [
        SectionHeader(
          title: "أفضل المتخصصين",
          action: "عرض الكل",
          onAction: () => context.pushNamed(
            Routes.medical,
            arguments: MedicalScreenArgs(
              specialitiesCubit: context.read<GetSpecialitiesCubit>(),
              type: MedicalType.doctor,
            ),
          ),
        ),
        DoctorList(shrinkWrap: true, doctors: doctors, heroEnabled: hero),
      ],
    );
  }
}
