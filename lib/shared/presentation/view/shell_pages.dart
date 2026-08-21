part of "app_shell_screen.dart";

class _ShellPage {
  final BottomNavItem navbar;
  final Widget body;

  _ShellPage({required this.navbar, required this.body});
}

final List<_ShellPage> _pages = [
  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.home, title: "الرئيسية"),
    body: const SizedBox.shrink(),
  ),
  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.explore, title: "استكشف"),

    body: const SizedBox.shrink(),
  ),
  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.appointment, title: "حجوزاتى"),

    body: const SizedBox.shrink(),
  ),
  _ShellPage(
    navbar: const BottomNavItem(icon: AppIcons.profile, title: "حسابى"),

    body: const SizedBox.shrink(),
  ),
];

extension _MainLayoutPages on List<_ShellPage> {
  List<BottomNavItem> get navBars => map((e) => e.navbar).toList();
}
