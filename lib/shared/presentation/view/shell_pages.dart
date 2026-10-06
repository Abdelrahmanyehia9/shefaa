part of "app_shell_screen.dart";

class _ShellPage {
  final BottomNavItem navbar;
  final Widget body;
  final double hPadding, vPadding;
  final PreferredSizeWidget? appbar;
  final bool topPadding ;
  final bool authGuard ;

  _ShellPage({
    required this.navbar,
    this.hPadding = 16,
    this.vPadding = 16,
    this.appbar,
    required this.body,
    this.authGuard = false,
    this.topPadding = false ,
  });
}

final List<_ShellPage> _pages = [
  _ShellPage(
    hPadding: 0,
    navbar: const BottomNavItem(icon: AppIcons.home, title: "الرئيسية"),
    body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<GetHomeNearbyClinicCubit>()..getNearbyClinics(),
        ),
        BlocProvider(
          create: (context) =>
              sl<GetHomeTopRatedDoctorsCubit>()..getTopRatedDoctors(),
        ),
      ],
      child: const HomeScreen(),
    ),
    topPadding: true
  ),

  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.appointment, title: "حجوزاتى"),
    hPadding: 0,
    authGuard: true,
    appbar: AppBar(title: const AppText("حجوزاتى"),),

    body: const MyBookingsScreen(),
  ),
  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.favorite, title: "المفضلة"),
    vPadding: 0,
    authGuard: true,
    appbar: AppBar(title: const AppText("المفضلة"),),
    hPadding: 0,
    body: const FavoriteScreen(),
  ),
  _ShellPage(
    hPadding: 0,
    navbar: const BottomNavItem(icon: AppIcons.profile, title: "حسابى"),
    body: const ProfileScreen(),
  ),
];

extension _MainLayoutPages on List<_ShellPage> {
  List<BottomNavItem> get navBars => map((e) => e.navbar).toList();
}
