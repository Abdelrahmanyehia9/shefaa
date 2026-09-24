import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/entity/payment_entity.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_clinic_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_doctor_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_info_card.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/my_booking_actions.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/payment_info_card.dart';
import 'package:shefaa/features/medical/shared/domain/entity/patient_entity.dart';
import 'package:shefaa/shared/presentation/view/layout/sticky_bottom_layout.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/default_sticky_button.dart';
import 'package:shefaa/shared/presentation/view/widgets/patient_card.dart';

class MyBookingDetailsScreen extends StatelessWidget {
  final BookingEntity booking;
  const MyBookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      appBar: AppBar(title: const AppText("تفاصيل الحجز")),
      body: StickyBottomLayout(
        content: AppStaggeredAnimation(
          spacing: UISizes.sp12,
          children: [
            BookingInfoCard(booking: booking),
            _buildDoctorAndClinicInfo(booking, context),
            _buildPatientInfo(booking.customPatient, context),
            _buildPaymentInfo(booking.lastPayment),
          ],
        ).paddingHr,
        sticky: DefaultStickyFooter(
          customButton: MyBookingActions(booking: booking,),
        ),
      ),
    );
  }

  Widget _buildDoctorAndClinicInfo(BookingEntity booking, BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: "معلومات الدكتور", paddingVr: UISizes.sp4),
        AppClick(
            onTap: ()=>context.pushNamed(Routes.doctor, arguments: booking.doctor),
            child: BookingDoctorInfo(doctor: booking.doctor)),
        Gap.small(),
        if (booking.clinic != null)
          AppClick(
              onTap: ()=>context.pushNamed(Routes.clinic, arguments: booking.clinic),
              child: BookingClinicInfo(clinic: booking.clinic!, showLocation: true)),
      ],
    );
  }

  Widget _buildPatientInfo(PatientEntity? patient, BuildContext context) {
    final patientKinship = patient == null
        ? "حجز لنفسي"
        : "احجز بالنيابة عن ${patient.kinship?.text}";
    return Column(
      children: [
        SectionHeader(
          title: "معلومات المريض",
          paddingVr: UISizes.sp4,
          action: patientKinship,
          actionStyle: context.textTheme.titleSmall?.copyWith(
            fontSize: UISizes.sp12,
          ),
        ),
        PatientCard(patient: patient),
      ],
    );
  }

  Widget _buildPaymentInfo(PaymentEntity payment) {
    return Column(
      children: [
        SectionHeader(title: "ملعومات الدفع", paddingVr: UISizes.sp4),
        PaymentInfoCard(payment: payment),
      ],
    );
  }
}
