part of "../clinic_screen.dart";

class _ClinicBio extends StatelessWidget {
  final String bio;

  const _ClinicBio(this.bio);

  @override
  Widget build(BuildContext context) {
    return AppReadMore(
      text: bio,

      style: context.textTheme.bodyMedium?.copyWith(
        color: context.colors.surfaceContainer,
      ),
    );
  }
}
