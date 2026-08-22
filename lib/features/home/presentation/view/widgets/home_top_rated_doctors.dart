part of "../home_screen.dart";

class _HomeTopRatedDoctors extends StatelessWidget {
  const _HomeTopRatedDoctors();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "أفضل المتخصصين", action: "عرض الكل",),
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_,i)=>const DoctorCard(),
          separatorBuilder: (_,_)=>Gap.small(),
          itemCount: 3,
        ),
      ],
    );
  }
}
