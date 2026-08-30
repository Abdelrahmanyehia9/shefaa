import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/clinic/presentation/controllers/get_all_clinics_cubit.dart';
import 'package:shefaa/shared/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/presentation/controllers/get_specialities_cubit.dart';
import 'package:shefaa/shared/presentation/view/layout/clinic_list.dart';
import 'package:shefaa/shared/presentation/view/layout/speciality_filters_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_search_button.dart';

class AllClinicsScreen extends StatelessWidget {
  const AllClinicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppText("العيادات"),
        actions: const [AppSearchButton()],
      ),

      body: Column(
        spacing: UISizes.h16,
        children: [
          BaseBlocConsumer<GetSpecialitiesCubit, List<SpecialityEntity>>(
            successBuilder: (specialities) => SpecialityFiltersList(
              specialities: specialities,
              onChanged: (i) {},
            ),
          ),
          Expanded(
            child:
                BaseBlocConsumer<
                  GetAllClinicsCubit,
                  PaginationData<ClinicEntity>
                >(
                  successBuilder: (c) => _buildClinicList(c.data),
                  loadingBuilder: () =>
                      _buildClinicList(ClinicEntity.mock.fakeList(12)),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicList(List<ClinicEntity> e) =>
      ClinicList(axis: Axis.vertical, clinics: e);
}
