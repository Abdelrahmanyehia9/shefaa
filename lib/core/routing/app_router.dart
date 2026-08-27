import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/auth/presentation/controller/sign_in_email_and_password_cubit.dart';
import 'package:shefaa/features/auth/presentation/controller/sign_up_email_and_password_cubit.dart';
import 'package:shefaa/features/booking/presentation/view/book_doctor_screen.dart';
import 'package:shefaa/features/clinic/presentation/view/all_clinics_screen.dart';
import 'package:shefaa/features/clinic/presentation/view/clinic_screen.dart';
import 'package:shefaa/features/doctor/presentation/view/all_doctors_screen.dart';
import 'package:shefaa/features/doctor/presentation/view/doctor_screen.dart';
import 'package:shefaa/features/favorite/presentation/view/favorite_screen.dart';
import 'package:shefaa/features/home/presentation/view/speciality_categories_screen.dart';
import 'package:shefaa/features/notifications/presentation/view/notification_screen.dart';
import 'package:shefaa/features/profile/presentation/view/complete_profile_screen.dart';
import 'package:shefaa/features/auth/presentation/view/otp_screen.dart';
import 'package:shefaa/features/auth/presentation/view/sign_in_screen.dart';
import 'package:shefaa/features/auth/presentation/view/sign_up_screen.dart';
import 'package:shefaa/features/auth/presentation/view/change_password_screen.dart';
import 'package:shefaa/features/auth/presentation/view/reset_password_screen.dart';
import 'package:shefaa/features/intro/presentation/view/onboarding_screen.dart';
import 'package:shefaa/features/intro/presentation/view/splash_screen.dart';
import 'package:shefaa/features/location/presentation/view/location_access_screen.dart';
import 'package:shefaa/features/profile/presentation/controller/complete_profile_cubit.dart';
import 'package:shefaa/features/profile/presentation/view/edit_profile_screen.dart';
import 'package:shefaa/features/profile/presentation/view/settings_screen.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';
import 'package:shefaa/shared/presentation/controllers/bottom_navigation_cubit.dart';
import 'package:shefaa/shared/presentation/view/app_shell_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _page(const SplashScreen(), name: Routes.splash);
      case Routes.onboarding:
        return _page(const OnBoardingScreen(), name: Routes.onboarding);
      case Routes.signIn:
        return _page(
          BlocProvider(
            create: (context) => sl<SignInEmailAndPasswordCubit>(),
            child: const SignInScreen(),
          ),
          name: Routes.signIn,
        );
      case Routes.signUp:
        return _page(
          BlocProvider(
            create: (context) => sl<SignUpEmailAndPasswordCubit>(),
            child: const SignUpScreen(),
          ),
          name: Routes.signUp,
        );
      case Routes.otp:
        return _page(const OtpScreen(), name: Routes.otp);
      case Routes.resetPassword:
        return _page(const ResetPasswordScreen(), name: Routes.resetPassword);
      case Routes.changePassword:
        return _page(const ChangePasswordScreen(), name: Routes.changePassword);
      case Routes.completeProfile:
        final user = settings.arguments as UserEntity;
        return _page(
          BlocProvider(
            create: (context) => sl<CompleteProfileCubit>(),
            child: CompleteProfileScreen(user: user),
          ),
          name: Routes.completeProfile,
        );
      case Routes.locationAccess:
        return _page(const LocationAccessScreen(), name: Routes.locationAccess);
      case Routes.shell:
        return _page(
          BlocProvider(
            create: (context) => BottomNavigationCubit(),
            child: const AppShellScreen(),
          ),
          name: Routes.shell,
        );
      case Routes.editProfile:
        return _page(const EditProfileScreen(), name: Routes.editProfile);
      case Routes.settings:
        return _page(const SettingsScreen(), name: Routes.settings);
      case Routes.favorite:
        return _page(const FavoriteScreen(), name: Routes.favorite);

      case Routes.notifications:
        return _page(const NotificationScreen(), name: Routes.notifications);

      case Routes.specialityCategories:
        return _page(
          const SpecialityCategoriesScreen(),
          name: Routes.specialityCategories,
        );
      case Routes.doctors:
        return _page(const AllDoctorsScreen(), name: Routes.doctors);
      case Routes.clinics:
        return _page(const AllClinicsScreen(), name: Routes.clinics);
      case Routes.doctor:
        return _page(const DoctorScreen(), name: Routes.doctor);
      case Routes.clinic:
        return _page(const ClinicScreen(), name: Routes.doctor);
      case Routes.bookDoctor:
        return _page(const BookDoctorScreen(), name: Routes.doctor);

      default:
        return null;
    }
  }

  MaterialPageRoute _page(Widget child, {String? name}) => MaterialPageRoute(
    builder: (_) => child,
    settings: RouteSettings(name: name),
  );
}
