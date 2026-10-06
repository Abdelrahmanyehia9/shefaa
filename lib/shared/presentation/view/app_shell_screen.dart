import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_bottom_nav_bar.dart';
import 'package:shefaa/core/components/app_logo.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/extensions/snack_bar.dart';
import 'package:shefaa/core/helper/auth_guard.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/presentation/view/my_bookings_screen.dart';
import 'package:shefaa/features/favorite/presentation/view/favorite_screen.dart';
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
      builder: (context, index) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) => _cubit.onPopScoped(
          onConfirm: () => context.flash(
            icon: AppLogo(size: UISizes.sp20),
            message: "اضغط مرة اخرى للخروج",
          ),
          onExit: SystemNavigator.pop,
        ),
        child: AppScaffold(
          topPadding: _pages[index].topPadding,
          appBar: _pages[index].appbar,
          body: IndexedStack(
            index: index,
            children: _pages.map((page) => page.body).toList(),
          ),
          hPadding: _pages[index].hPadding,
          vPadding: _pages[index].vPadding,
          bottomPadding: false,
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: index,
            onTap: (i) {
              if (_pages[i].authGuard) {
                AuthGuard.run(
                  context: context,
                  onAuthenticated: () => _cubit.changePage(i),
                );
              } else {
                _cubit.changePage(i);
              }
            },
            items: _pages.navBars,
          ),
        ),
      ),
    );
  }
}
