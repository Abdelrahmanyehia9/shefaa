import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/features/booking/presentation/view/forms/patient_form.dart';
import 'package:shefaa/shared/presentation/view/widgets/patient_card.dart';

class BookingPatientInfo extends StatefulWidget {
  const BookingPatientInfo({super.key});

  @override
  State<BookingPatientInfo> createState() => _BookingPatientInfoState();
}

class _BookingPatientInfoState extends State<BookingPatientInfo> {
  final ValueNotifier<bool> _selfBookingNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selfBookingNotifier,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: "بيانات المريض",
              customAction: AppChip(
                titleStyle: context.textTheme.titleSmall,
                title: value ? "احجز لشخص اخر" : "احجز لنفسي",
              ),
              onAction: () =>
                  _selfBookingNotifier.value = !_selfBookingNotifier.value,
            ),
            if (value) //isME
              const PatientCard()
            else
              const PatientForm(),
          ],
        );
      },
    );
  }
}
