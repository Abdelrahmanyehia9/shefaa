part of '../doctor_screen.dart';

class _DoctorHeader extends StatelessWidget {
  const _DoctorHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISizes.w8,
      children: [
        UserAvatar(
          size: UISizes.sp84,
          image:
              "https://thumbs.dreamstime.com/b/african-american-man-male-doctor-27757329.jpg",
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "دكتور خالد احمد",
                          style: context.textTheme.labelLarge,
                        ),
                        AppText(
                          "استشارى قلب",
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  AppIconText(
                    icon: AppIcons.clinic,
                    iconSize: UISizes.sp16,
                    textStyle: context.textTheme.titleSmall,
                    color: context.colors.primary,
                    text: "عيادة الحياه",
                  ),
                ],
              ),
              Row(
                spacing: UISizes.w4,
                children: [
                  const AppRatingStars(rating: 2.6),
                  Expanded(
                    child: AppTextHighLight(
                      "(التقييم  من *124* مراجعة)",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.surfaceContainer,
                      ),
                      highlighterStyle: context.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
