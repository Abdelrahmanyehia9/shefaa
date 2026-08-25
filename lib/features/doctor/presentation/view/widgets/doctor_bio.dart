part of "../doctor_screen.dart";

class _DoctorBio extends StatelessWidget {
  const _DoctorBio();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "عن الدكتور", action: "تفاصيل"),
        AppReadMore(
          style: context.textTheme.bodyMedium,
          maxLines: 2,
          text:
              " طبيب متخصص بخبرة تزيد عن 10 سنوات، يقدم رعاية طبية متميزة ويهتم بتقديم أفضل الحلول العلاجية المناسبة لكل مريض.",
        ),
      ],
    );
  }
}
