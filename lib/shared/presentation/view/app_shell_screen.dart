import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_bottom_nav_bar.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/presentation/view/my_bookings_screen.dart';
import 'package:shefaa/features/explore/presentation/view/explore_screen.dart';
import 'package:shefaa/features/home/presentation/controller/get_home_nearby_clinic_cubit.dart';
import 'package:shefaa/features/home/presentation/controller/get_home_top_rated_doctors_cubit.dart';
import 'package:shefaa/features/home/presentation/view/home_screen.dart';
import 'package:shefaa/features/profile/presentation/view/profile_screen.dart';
import 'package:shefaa/shared/presentation/controllers/bottom_navigation_cubit.dart';

part 'shell_pages.dart';

class AppShellScreen extends StatefulWidget {
  const AppShellScreen({super.key});

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  BottomNavigationCubit get _cubit => context.read<BottomNavigationCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, index) => AppScaffold(
        body: IndexedStack(
          index: index,
          children: _pages.map((page) => page.body).toList(),
        ),
        hPadding: _pages[index].hPadding,
        vPadding: _pages[index].vPadding,
        topPadding: _pages[index].safeTop,
        bottomPadding: false,
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: index,
          onTap: _cubit.changePage,
          items: _pages.navBars,
        ),
      ),
    );
  }
}
