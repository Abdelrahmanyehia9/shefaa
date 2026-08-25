part of "../doctor_screen.dart";

class _DoctorLocation extends StatelessWidget {
  const _DoctorLocation();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "الموقع", action: "عرض على الخريطة"),
        const Divider(),
        AppIconText(
          expandedText: true,
          icon: AppIcons.bookingLocation,
          iconColor: context.colors.primary,
          textStyle: context.textTheme.labelMedium,
          text: "12 شارع اكتوبر حمص , سويا",
        ),
        Gap.small(),
        SizedBox(height: UISizes.h148, child: const MapView()),
      ],
    );
  }
}
