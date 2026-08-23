import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_bottom_nav_bar.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/utils/app_icons.dart';
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
        body: _pages[index].body,
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: index,
          onTap: _cubit.changePage,
          items: _pages.navBars,
        ),
      ),
    );
  }
}
