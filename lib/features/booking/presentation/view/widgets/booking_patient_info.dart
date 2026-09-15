import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/features/booking/presentation/controller/patient_form_controller.dart';
import 'package:shefaa/features/booking/presentation/view/forms/patient_form.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/create_booking_consumer.dart';
import 'package:shefaa/shared/presentation/view/widgets/patient_card.dart';

class BookingPatientInfo extends StatelessWidget {
  final PatientFormController controller;
  const BookingPatientInfo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CreateBookingConsumer(
      onInit: (_, _, state) => controller.selfBooking = state.isSelfBooking,
      initBuilder: (context, cubit, state) {
        final isMe = state.isSelfBooking;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: "بيانات المريض",
              customAction: AppChip(
                titleStyle: context.textTheme.titleSmall,
                title: isMe ? "احجز لشخص اخر" : "احجز لنفسي",
              ),
              onAction: () => cubit.toggleSelfBooking(),
            ),
            if (isMe) //isME
              const PatientCard()
            else
              PatientForm(controller: controller),
          ],
        );
      },
    );
  }
}
