import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/shared/presentation/view/widgets/doctor_header.dart';

class BookingDoctorInfo extends StatelessWidget {
  const BookingDoctorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: const DoctorHeader(showClinicName: false).appPaddingAll(8),
    );
  }
}
