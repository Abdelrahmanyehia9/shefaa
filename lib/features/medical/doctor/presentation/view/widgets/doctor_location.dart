part of "../doctor_screen.dart";

class _DoctorLocation extends StatelessWidget {
  final LocationEntity location;
  const _DoctorLocation(this.location);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "الموقع", action: "عرض على الخريطة"),
        const Divider(),
        if (location.name != null)
          AppIconText(
            expandedText: true,
            icon: AppIcons.bookingLocation,
            iconColor: context.colors.primary,
            textStyle: context.textTheme.labelMedium,
            text: location.name,
          ),
        Gap.small(),
        SizedBox(height: UISizes.h148, child: const MapView()),
      ],
    );
  }
}
