import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/enum/medical_type.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/clinic/presentation/controllers/get_all_clinics_cubit.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_all_doctors_cubit.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_all_clinics.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/medical_all_doctors.dart';
import 'package:shefaa/features/medical/speciality/presentation/controller/get_specialities_cubit.dart';
import 'package:shefaa/shared/presentation/view/widgets/app_search_bar.dart';

final class MedicalScreenArgs {
  final MedicalType type ;
  final GetSpecialitiesCubit specialitiesCubit ;
  const MedicalScreenArgs({required this.specialitiesCubit, required this.type});
}



class MedicalScreen extends StatelessWidget {
  final MedicalType type  ;
  const MedicalScreen({super.key, this.type = MedicalType.doctor});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppText(type.text)
      ),
      body: Column(
        spacing: UISizes.h16,
        children: [
          AppSearchBar(hint: "البحث فى ${type.text} .....",),
          Expanded(child: _body(type)),
        ],
      )
    );


  }

  Widget _body(MedicalType type)=>switch(type){
    MedicalType.doctor =>BlocProvider(
        create: (context)=>sl<GetAllDoctorsCubit>()..getAll(),
        child: const MedicalAllDoctors()) ,
    _=>BlocProvider(
        create: (context)=>sl<GetAllClinicsCubit>()..getAll(),
        child: const MedicalAllClinics())
  };
}
