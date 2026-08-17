import 'package:flutter/material.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/intro/presentation/view/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _page(const SplashScreen(), name: Routes.splash);

      default:
        return null;
    }
  }

  MaterialPageRoute _page(Widget child, {String? name}) => MaterialPageRoute(
    builder: (_) => child,
    settings: RouteSettings(name: name),
  );
}
