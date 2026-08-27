import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/layout/clinic_list.dart';
import 'package:shefaa/shared/presentation/view/layout/doctor_list.dart';

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
    _tabController = TabController(length: 2, vsync: this);
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
          tabs: const [
            Tab(text: "الاطباء"),
            Tab(text: "العيادات"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const DoctorList().paddingAll,
          const ClinicList(axis: Axis.vertical).paddingAll,
        ],
      ),
    );
  }
}
