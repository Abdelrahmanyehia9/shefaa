part of "../home_screen.dart";

class _HomeTopRatedDoctors extends StatelessWidget {
  const _HomeTopRatedDoctors();

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<GetHomeTopRatedDoctorsCubit, List<DoctorEntity>>(
      successBuilder: (d) => _builder(context, doctors: d,),
      loadingBuilder: () =>
          _builder(context, doctors: DoctorEntity.mock.fakeList(4)),
    );
  }

  Widget _builder(
    BuildContext context, {
    required List<DoctorEntity> doctors,
  }) {
    return Column(
      children: [
        SectionHeader(
          title: "أفضل المتخصصين",
          action: "عرض الكل",
          onAction: () => context.pushNamed(
            Routes.medical,
            arguments: const MedicalScreenArgs(type: MedicalType.doctor),
          ),
        ),
        DoctorList(shrinkWrap: true, doctors: doctors, ),
      ],
    );
  }
}
