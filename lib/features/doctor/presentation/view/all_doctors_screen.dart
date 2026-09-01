import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_refreshable.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/doctor/presentation/controller/get_all_doctors_cubit.dart';
import 'package:shefaa/shared/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/presentation/controllers/get_specialities_cubit.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_view_mixin.dart';
import 'package:shefaa/shared/presentation/view/layout/doctor_list.dart';
import 'package:shefaa/shared/presentation/view/layout/speciality_filters_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_search_button.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen>
    with PaginationViewMixin<AllDoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppText("الاطباء"),
        actions: const [AppSearchButton()],
      ),

      body: AppRefreshable(
        onRefresh: () => _onRefresh(context),
        child: Column(
          spacing: UISizes.h16,
          children: [
            BaseBlocConsumer<GetSpecialitiesCubit, List<SpecialityEntity>>(
              successBuilder: (specialities) => SpecialityFiltersList(
                specialities: specialities,
                onChanged: (i) => _onSpecialityChanged(
                  context,
                  i == -1 ? null : specialities[i].id,
                ),
              ),
            ),
            Expanded(
              child:
                  BaseBlocConsumer<
                    GetAllDoctorsCubit,
                    PaginationData<DoctorEntity>
                  >(
                    onSuccess: initPagination,
                    successBuilder: (c) =>
                        _buildDoctorList(c.data, footer: paginationFooter()),
                    loadingBuilder: () =>
                        _buildDoctorList(DoctorEntity.mock.fakeList(12)),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorList(List<DoctorEntity> e, {Widget? footer}) =>
      DoctorList(controller: scrollController, doctors: e, footer: footer);
  Future<void> _onRefresh(BuildContext context) =>
      context.read<GetAllDoctorsCubit>().getDoctors();
  @override
  Future<void> onLoadMore() =>
      context.read<GetAllDoctorsCubit>().loadMoreDoctors();
  void _onSpecialityChanged(BuildContext context, int? specialityId) =>
      context.read<GetAllDoctorsCubit>().fetchBySpeciality(specialityId);
}
