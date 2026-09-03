import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/shared/presentation/view/widgets/clinic_preview_card.dart';

class BookingClinicInfo extends StatelessWidget {
  const BookingClinicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: const ClinicPreviewCard().appPaddingAll(8));
  }
}
