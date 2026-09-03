import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_refreshable.dart';
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
import 'package:shefaa/shared/presentation/mixin/pagination_view_mixin.dart';
import 'package:shefaa/shared/presentation/view/layout/clinic_list.dart';
import 'package:shefaa/shared/presentation/view/layout/speciality_filters_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_search_button.dart';

class AllClinicsScreen extends StatefulWidget {
  const AllClinicsScreen({super.key});

  @override
  State<AllClinicsScreen> createState() => _AllClinicsScreenState();
}

class _AllClinicsScreenState extends State<AllClinicsScreen>
    with PaginationViewMixin<AllClinicsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppText("العيادات"),
        actions: const [AppSearchButton()],
      ),
      body: AppRefreshable(
        onRefresh: () => _onRefresh(context),
        child: Column(
          spacing: UISizes.h16,
          children: [
            BaseBlocConsumer<GetSpecialitiesCubit, List<SpecialityEntity>>(
              successBuilder: (s) {
                final specialities = s.sortedByClinics;
                return SpecialityFiltersList(
                  specialities: specialities,
                  onChanged: (i) => _onSpecialityChanged(
                    context,
                    i == -1 ? null : specialities[i].id,
                  ),
                );
              },
            ),
            Expanded(
              child:
                  BaseBlocConsumer<
                    GetAllClinicsCubit,
                    PaginationData<ClinicEntity>
                  >(
                    onSuccess: initPagination,
                    successBuilder: (c) => _buildClinicList(
                      c.data,
                      footer: paginationFooter(),
                      heroEnabled: true,
                    ),
                    loadingBuilder: () =>
                        _buildClinicList(ClinicEntity.mock.fakeList(12)),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClinicList(
    List<ClinicEntity> e, {
    Widget? footer,
    bool heroEnabled = false,
  }) {
    return ClinicList(
      axis: Axis.vertical,
      heroEnabled: heroEnabled,
      footer: footer,
      clinics: e,
      controller: scrollController,
    );
  }

  @override
  Future<void> onLoadMore() =>
      context.read<GetAllClinicsCubit>().loadMoreClinics();

  Future<void> _onRefresh(BuildContext context) =>
      context.read<GetAllClinicsCubit>().getClinics(forceRefresh: true);

  void _onSpecialityChanged(BuildContext context, int? specialityId) =>
      context.read<GetAllClinicsCubit>().fetchBySpeciality(specialityId);
}
