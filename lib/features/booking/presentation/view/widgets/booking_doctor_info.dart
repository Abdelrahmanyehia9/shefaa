import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/doctor_header.dart';

class BookingDoctorInfo extends StatelessWidget {
  const BookingDoctorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DoctorHeader(doctor: DoctorEntity.mock).appPaddingAll(8),
    );
  }
}
