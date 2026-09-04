import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_refreshable.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/enum/medical_type.dart';
import 'package:shefaa/core/enum/speciality_tags.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/medical/shared/presentation/medical_screen.dart';
import 'package:shefaa/shared/presentation/view/widgets/appointment_card.dart';
import 'package:shefaa/features/home/presentation/controller/get_home_top_rated_doctors_cubit.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/features/home/presentation/controller/get_home_nearby_clinic_cubit.dart';
import 'package:shefaa/features/medical/speciality/presentation/controller/get_specialities_cubit.dart';
import 'package:shefaa/features/medical/speciality/presentation/view/layout/speciality_categories_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_notification_icon.dart';
import 'package:shefaa/features/medical/clinic/presentation/view/layout/clinic_list.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/layout/doctor_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/app_search_bar.dart';

part 'widgets/home_app_bar.dart';

part 'widgets/home_speciality_categories.dart';
part 'widgets/home_top_rated_doctors.dart';
part 'widgets/home_next_appointment.dart';

part 'widgets/home_nearby_clinic.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRefreshable(
      onRefresh: () => onRefreshPage(context),
      child: SingleChildScrollView(
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
        ).paddingHr,
      ),
    );
  }

  Future<void> onRefreshPage(BuildContext context) async {
    context.read<GetSpecialitiesCubit>().getSpecialities(forceRefresh: true);
    context.read<GetHomeNearbyClinicCubit>().getNearbyClinics(
      forceRefresh: true,
    );
    context.read<GetHomeTopRatedDoctorsCubit>().getTopRatedDoctors(
      forceRefresh: true,
    );
  }
}
