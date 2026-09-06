import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_cubit.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_clinic_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_doctor_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_select_date.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_select_time.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_availability_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_doctor_availability_cubit.dart';

class BookingFormV1 extends StatelessWidget {
  final DoctorEntity doctor;
  final ClinicEntity? clinic;

  const BookingFormV1({super.key, required this.doctor, this.clinic});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AppStaggeredAnimation(
        children: [
          BookingDoctorInfo(doctor: doctor),
          if (clinic != null) BookingClinicInfo(clinic: clinic!),
          BaseBlocConsumer<GetDoctorAvailabilityCubit, List<DoctorAvailabilityEntity>>(
            successBuilder: (data) => _TimeSlots(data: data),
            loadingBuilder: () => _TimeSlots(data: DoctorAvailabilityEntity.mock.fakeList(7)),
          ),
        ],
      ),
    );
  }
}

class _TimeSlots extends StatelessWidget {
  final List<DoctorAvailabilityEntity> data;

  const _TimeSlots({required this.data});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateBookingCubit>();

    return AnimatedBuilder(
      animation: Listenable.merge([cubit.selectDate, cubit.selectedTime]),
      builder: (_, _) {
        final dateIndex = data.indexWhere((e) => e.date == cubit.selectDate.value);
        final slots = dateIndex < 0 ? null : data[dateIndex].availability;
        final timeIndex = slots?.indexWhere((e) => e.time == cubit.selectedTime.value) ?? -1;
        return Column(
          children: [
            BookingSelectDate(
              availability: data,
              initialIndex: dateIndex < 0 ? null : dateIndex,
              onChanged: (i) => cubit
                ..selectDate.value = data[i].date
                ..selectedTime.value = null,
            ),
            if (slots != null)
              BookingSelectTime(
                slots: slots,
                initialIndex: timeIndex == -1 ? null : timeIndex,
                onChanged: (i) => cubit.selectedTime.value = slots[i].time,
              ).animate()
               .fadeIn(duration: 400.ms),
          ],
        );
      },
    );
  }
}