part of '../home_screen.dart';

class _HomeNextAppointment extends StatefulWidget {
  const _HomeNextAppointment();

  @override
  State<_HomeNextAppointment> createState() => _HomeNextAppointmentState();
}

class _HomeNextAppointmentState extends State<_HomeNextAppointment> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<GetBookingsCubit, PaginationData<BookingEntity>>(
      successBuilder: (s) {
        final upcoming = s.data.upcomingBookings;
        final remining = upcoming.length - 1;
        if (upcoming.isEmpty) return const SizedBox.shrink();
        return Column(

          children: [
            SectionHeader(
              customTitle: AppIconText(
                text: "لديك حجز قادم",
                textStyle: context.textTheme.titleMedium,
                reverse: true,
                customIcon: Badge(
                        isLabelVisible:  remining > 0,
                        backgroundColor: context.colors.primary,
                        label: AppText("+$remining"),
                        textStyle: context.textTheme.titleSmall,
                      ),
              ),
              action:  "الى الحجوزات",
              onAction: () => context.read<BottomNavigationCubit>().changePage(2),
            ),
            AppointmentCard(booking: upcoming.last),
          ],
        );
      },
    );
  }
}
