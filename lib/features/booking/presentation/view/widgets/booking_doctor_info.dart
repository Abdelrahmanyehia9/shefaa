import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/widgets/doctor_preview_card.dart';

class BookingDoctorInfo extends StatelessWidget {
  final DoctorEntity doctor ;
  const BookingDoctorInfo({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DoctorPreviewCard(doctor: doctor).appPaddingAll(8),
    );
  }
}
