part of "../doctor_screen.dart";

class _DoctorBio extends StatelessWidget {
  final String bio;
  const _DoctorBio(this.bio);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "عن الدكتور", action: "تفاصيل"),
        AppReadMore(
          style: context.textTheme.bodyMedium,
          maxLines: 2,
          text: bio.trim(),
        ),
      ],
    );
  }
}
