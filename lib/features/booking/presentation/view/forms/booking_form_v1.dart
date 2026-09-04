import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_stragged_animation.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_clinic_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_doctor_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_select_date.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_select_time.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';

class BookingFormV1 extends StatelessWidget {
  final DoctorEntity  doctor;
  final ClinicEntity? clinic ;
  const BookingFormV1({super.key, required this.doctor, this.clinic});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: AppStaggeredAnimation(
        children: [
          BookingDoctorInfo(doctor: doctor,),
          if(clinic!=null)
          BookingClinicInfo(
            clinic: clinic!,
          ),
          BookingSelectDate(),
          BookingSelectTime(),
        ],
      ),
    );
  }
}
