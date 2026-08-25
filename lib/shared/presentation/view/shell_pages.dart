part of "app_shell_screen.dart";

class _ShellPage {
  final BottomNavItem navbar;
  final Widget body;
  final double hPadding, vPadding;
  final bool safeTop;

  _ShellPage({
    required this.navbar,
    this.hPadding = 16,
    this.vPadding = 16,
    required this.body,
    this.safeTop = true,
  });
}

final List<_ShellPage> _pages = [
  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.home, title: "الرئيسية"),
    body: const HomeScreen(),
  ),
  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.explore, title: "استكشف"),
    vPadding: 0,
    hPadding: 0,
    safeTop: false,
    body: const ExploreScreen(),
  ),
  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.appointment, title: "حجوزاتى"),
    hPadding: 0,
    body: const MyBookingsScreen(),
  ),
  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.profile, title: "حسابى"),

    body: const ProfileScreen(),
  ),
];

extension _MainLayoutPages on List<_ShellPage> {
  List<BottomNavItem> get navBars => map((e) => e.navbar).toList();
}
