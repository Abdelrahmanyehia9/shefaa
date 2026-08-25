part of "../clinic_screen.dart";

class _ClinicNameAndSpecialities extends StatelessWidget {
  const _ClinicNameAndSpecialities();

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
              image:
                  "https://nafezly-production.fra1.cdn.digitaloceanspaces.com/uploads/portfolios/29246_633eff9fd1484-1665073055.jpg",
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "عيادة الحياه",
                    height: 0,
                    style: context.textTheme.headlineSmall,
                  ),
                  AppText(
                    "أسنان، عيون، جلدية +12 تخصصًا آخر",
                    style: context.textTheme.bodyMedium,
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
        AppText(
          style: context.textTheme.bodyMedium,
          color: context.colors.surfaceContainer,
          "عيادة طبية متخصصة تقدم خدمات رعاية صحية متكاملة للمرضى، مع نخبة من الأطباء المتخصصين واهتمام بتوفير تجربة علاجية مريحة وآمنة.",
        ),
      ],
    );
  }
}
