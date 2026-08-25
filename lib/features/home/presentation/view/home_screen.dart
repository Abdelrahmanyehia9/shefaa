import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/shared/presentation/view/layout/speciality_categories_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_notification_icon.dart';
import 'package:shefaa/shared/presentation/view/layout/clinic_list.dart';
import 'package:shefaa/shared/presentation/view/layout/doctor_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/app_search_bar.dart';
import 'package:shefaa/shared/presentation/view/widgets/appointment_card.dart';

part 'widgets/home_app_bar.dart';

part 'widgets/home_speciality_categories.dart';
part 'widgets/home_top_rated_doctors.dart';
part 'widgets/home_next_appointment.dart';

part 'widgets/home_nearby_clinic.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: UISizes.h12,
        children: const [
          _HomeAppBar(),
          _HomeNextAppointment(),
          AppSearchBar(),
          _HomeSpecialityCategories(),
          _HomeNearbyClinic(),
          _HomeTopRatedDoctors(),
        ],
      ),
    );
  }
}
