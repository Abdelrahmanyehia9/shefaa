part of '../home_screen.dart';

class _HomeNextAppointment extends StatelessWidget {
  const _HomeNextAppointment();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(title: "لديك حجز قادم", action: "تفاصيل"),
        AppointmentCard(),
      ],
    );
  }
}
