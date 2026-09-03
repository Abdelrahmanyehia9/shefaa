part of "../clinic_screen.dart";

class _ClinicNameAndSpecialities extends StatelessWidget {
  final String? logo;

  final String name;
  final List<SpecialityEntity> specialities;

  const _ClinicNameAndSpecialities({
    required this.specialities,
    required this.name,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h16,
      children: [
        Row(
          spacing: UISizes.w8,
          children: [
            UserAvatar(
              size: UISizes.sp48,
              image:logo
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    name,
                    height: 0,
                    style: context.textTheme.headlineSmall,
                  ),
                  AppText(
                    specialitiesStr,
                    style: context.textTheme.labelMedium,
                    color: context.colors.surfaceContainer,
                  ),
                ],
              ),
            ),
            AppButton.text(
              style: context.textTheme.titleSmall,
              textColor: context.colors.primary,
              "تفاصيل",
            ),
          ],
        ),
      ],
    );
  }

  String get specialitiesStr {
    final visible = specialities.take(2).map((e) => e.title).join(', ');
    final remaining = specialities.length - 2;

    return remaining > 0
        ? '$visible +$remaining تخصص آخر'
        : visible;
  }
}
