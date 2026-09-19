import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/presentation/view/widgets/clinic_preview_card.dart';

class BookingClinicInfo extends StatelessWidget {
  final ClinicEntity clinic;
  final bool showLocation ;
  const BookingClinicInfo({super.key, this.showLocation = false, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Card(child: ClinicPreviewCard(clinic: clinic, showLocation: showLocation,).appPaddingAll(8));
  }
}
