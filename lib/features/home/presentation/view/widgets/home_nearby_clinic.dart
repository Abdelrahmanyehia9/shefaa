part of "../home_screen.dart" ;
class _HomeNearbyClinic extends StatelessWidget {
  const _HomeNearbyClinic();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "العيادات القريبة", action: "عرض الكل",),
        SizedBox(
          height: ClinicCard.cardSize.height,
          child: ListView.separated(
            clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_,i)=>const ClinicCard(),
              separatorBuilder: (_,_)=>HGap.small(),
              itemCount: 4
          ),
        ),
      ],
    );
  }
}
