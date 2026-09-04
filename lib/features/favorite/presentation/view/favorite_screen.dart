import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/enum/medical_type.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/favorite/presentation/view/widgets/favorite_builder.dart';
import 'package:shefaa/features/medical/clinic/presentation/view/layout/clinic_list.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/layout/doctor_list.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: MedicalType.favorite.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      vPadding: 0,
      appBar: AppBar(
        toolbarHeight: UISizes.h72,
        title: const AppText("المفضلة"),
        bottom: TabBar(
          controller: _tabController,
          tabs: MedicalType.favorite.map((e) => Tab(text: e.text)).toList(),
        ),
      ),
      body: FavoriteBuilder(
        builder: (cubit, favorites, _) {
          List<ClinicEntity> clinics =
              favorites?.whereType<ClinicEntity>().toList() ?? [];
          List<DoctorEntity> doctors =
              favorites?.whereType<DoctorEntity>().toList() ?? [];
          return TabBarView(
            controller: _tabController,
            children: [
              DoctorList(doctors: doctors).paddingAll,
              ClinicList(axis: Axis.vertical, clinics: clinics).paddingAll,
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose() ;
    super.dispose();
  }
}
