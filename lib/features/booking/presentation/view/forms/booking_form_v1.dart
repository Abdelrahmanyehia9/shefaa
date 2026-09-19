import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/booking/presentation/controller/booking_schedule_controller.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_clinic_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_doctor_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_select_date.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_select_time.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_availability_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_doctor_availability_cubit.dart';

class BookingFormV1 extends StatelessWidget {
  final DoctorEntity? doctor;
  final ClinicEntity? clinic;
  final BookingScheduleController controller;

  const BookingFormV1({
    super.key,
     this.doctor,
    required this.controller,
    this.clinic,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AppStaggeredAnimation(
        spacing: UISizes.h8,
        children: [
          if(doctor!=null)
          BookingDoctorInfo(doctor: doctor!),
          if (clinic != null) BookingClinicInfo(clinic: clinic!),
          Gap.medium(),
          BaseBlocConsumer<
            GetDoctorAvailabilityCubit,
            List<DoctorAvailabilityEntity>
          >(
            successBuilder: (data) =>
                _TimeSlots(data: data, controller: controller),
            emptyBuilder: () => ResultView.empty(
              message:
                  "عذرا لم نتمكن عن العثور على مواعيد متاحة لدى الدكتور ${doctor?.name??""} عاود المحاولة فى وقت اخر",
            ),
            loadingBuilder: () => _TimeSlots(
              data: DoctorAvailabilityEntity.mock.fakeList(7),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeSlots extends StatelessWidget {
  final List<DoctorAvailabilityEntity> data;
  final BookingScheduleController controller;
  const _TimeSlots({required this.data, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        final dateIndex = data.indexWhere(
          (e) => e.date == controller.selectedDate,
        );
        final slots = dateIndex == -1 ? null : data[dateIndex].availability;

        final timeIndex =
            slots?.indexWhere((e) => e.time == controller.selectedTime) ?? -1;

        return Column(
          spacing: UISizes.h8,
          children: [
            BookingSelectDate(
              availability: data,
              initialIndex: dateIndex == -1 ? null : dateIndex,
              onChanged: (i) => controller.selectDate(data[i].date),
            ),
            if (slots != null)
              BookingSelectTime(
                slots: slots,
                initialIndex: timeIndex == -1 ? null : timeIndex,
                onChanged: (i) => controller.selectTime(slots[i].time),
              ).animate().fadeIn(duration: 400.ms),
          ],
        );
      },
    );
  }
}
