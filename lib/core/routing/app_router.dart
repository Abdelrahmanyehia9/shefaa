import 'package:flutter/material.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/auth/presentation/view/complete_profile_screen.dart';
import 'package:shefaa/features/auth/presentation/view/otp_screen.dart';
import 'package:shefaa/features/auth/presentation/view/sign_in_screen.dart';
import 'package:shefaa/features/auth/presentation/view/sign_up_screen.dart';
import 'package:shefaa/features/auth/presentation/view/change_password_screen.dart';
import 'package:shefaa/features/auth/presentation/view/reset_password_screen.dart';
import 'package:shefaa/features/intro/presentation/view/onboarding_screen.dart';
import 'package:shefaa/features/intro/presentation/view/splash_screen.dart';
import 'package:shefaa/features/location/presentation/view/location_access_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _page(const SplashScreen(), name: Routes.splash);
      case Routes.onboarding:
        return _page(const OnBoardingScreen(), name: Routes.onboarding);
      case Routes.signIn:
        return _page(const SignInScreen(), name: Routes.signIn);
      case Routes.signUp:
        return _page(const SignUpScreen(), name: Routes.signUp);
      case Routes.otp:
        return _page(const OtpScreen(), name: Routes.otp);
      case Routes.resetPassword:
        return _page(const ResetPasswordScreen(), name: Routes.resetPassword);
      case Routes.changePassword:
        return _page(const ChangePasswordScreen(), name: Routes.changePassword);
      case Routes.completeProfile:
        return _page(
          const CompleteProfileScreen(),
          name: Routes.completeProfile,
        );
      case Routes.locationAccess:
        return _page(const LocationAccessScreen(), name: Routes.locationAccess);

      default:
        return null;
    }
  }

  MaterialPageRoute _page(Widget child, {String? name}) => MaterialPageRoute(
    builder: (_) => child,
    settings: RouteSettings(name: name),
  );
}
