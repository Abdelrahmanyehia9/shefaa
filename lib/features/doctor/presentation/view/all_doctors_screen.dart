import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/layout/doctor_list.dart';
import 'package:shefaa/shared/presentation/view/layout/speciality_filters_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_search_button.dart';

class AllDoctorsScreen extends StatelessWidget {
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppText("الاطباء"),
        actions: const [AppSearchButton()],
      ),

      body: Column(
        spacing: UISizes.h16,
        children: const [
          SpecialityFiltersList(initialIndex: 0),
          Expanded(child: DoctorList()),
        ],
      ),
    );
  }
}
