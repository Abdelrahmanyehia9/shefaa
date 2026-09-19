import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/auth/presentation/controller/sign_in_email_and_password_cubit.dart';
import 'package:shefaa/features/auth/presentation/controller/sign_up_email_and_password_cubit.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/controller/cancel_booking_cubit.dart';
import 'package:shefaa/features/booking/presentation/controller/change_booking_date_cubit.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_cubit.dart';
import 'package:shefaa/features/booking/presentation/controller/get_bookings_cubit.dart';
import 'package:shefaa/features/booking/presentation/view/book_doctor_screen.dart';
import 'package:shefaa/features/booking/presentation/view/cancel_booking_screen.dart';
import 'package:shefaa/features/booking/presentation/view/my_booking_details_screen.dart';
import 'package:shefaa/features/booking/presentation/view/reschedule_booking_screen.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/presentation/controllers/get_all_clinics_cubit.dart';
import 'package:shefaa/features/medical/clinic/presentation/controllers/get_x_clinic_cubit.dart';
import 'package:shefaa/features/medical/clinic/presentation/view/clinic_screen.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_all_doctors_cubit.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_doctor_availability_cubit.dart';
import 'package:shefaa/features/medical/doctor/presentation/controller/get_x_doctor_cubit.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/doctor_screen.dart';
import 'package:shefaa/features/favorite/presentation/view/favorite_screen.dart';
import 'package:shefaa/features/medical/shared/presentation/controller/filters_cubit.dart';
import 'package:shefaa/features/medical/speciality/presentation/view/speciality_categories_screen.dart';
import 'package:shefaa/features/medical/shared/presentation/medical_screen.dart';
import 'package:shefaa/features/notifications/presentation/view/notification_screen.dart';
import 'package:shefaa/features/profile/presentation/controller/update_profile_cubit.dart';
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
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/features/review/presentation/review_booking_screen.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';
import 'package:shefaa/shared/presentation/controllers/bottom_navigation_cubit.dart';
import 'package:shefaa/features/medical/speciality/presentation/controller/get_specialities_cubit.dart';
import 'package:shefaa/shared/presentation/controllers/local_search_cubit.dart';
import 'package:shefaa/shared/presentation/view/app_shell_screen.dart';
import 'package:shefaa/features/medical/shared/presentation/filters_screen.dart';
import 'package:shefaa/shared/presentation/view/result_screen.dart';

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
        final int? initial = settings.arguments as int?;
        return _page(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BottomNavigationCubit(initial ?? 0),
              ),
              BlocProvider(
                create: (context) =>
                    sl<GetBookingsCubit>()..loadFirstPage(null),
              ),
            ],
            child: const AppShellScreen(),
          ),
          name: Routes.shell,
        );
      case Routes.editProfile:
        return _page(BlocProvider(
            create: (c)=>sl<UpdateProfileCubit>(),
            child: const EditProfileScreen()), name: Routes.editProfile);
      case Routes.settings:
        return _page(const SettingsScreen(), name: Routes.settings);
      case Routes.favorite:
        return _page(const FavoriteScreen(), name: Routes.favorite);

      case Routes.notifications:
        return _page(const NotificationScreen(), name: Routes.notifications);

      case Routes.specialityCategories:
        return _page(
          BlocProvider(
            create: (c) => LocalSearchCubit<SpecialityEntity>(
              matcher: (item, query) =>
                  item.title.toLowerCase().contains(query),
            )..init(c.read<GetSpecialitiesCubit>().state.data??[]),
            child: const SpecialityCategoriesScreen(),
          ),
          name: Routes.specialityCategories,
        );
      case Routes.medical:
        final args = settings.arguments as MedicalScreenArgs;
        return _page(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<GetAllDoctorsCubit>(
                  param1: args.initialRequest as DoctorRequest?,
                )..init(),
              ),
              BlocProvider(
                create: (context) => sl<GetAllClinicsCubit>(
                  param1: args.initialRequest as ClinicRequest?,
                )..init(),
              ),
            ],
            child: MedicalScreen(
              type: args.type,
              initialRequest: args.initialRequest,
            ),
          ),
          name: Routes.medical,
        );

      case Routes.doctor:
        final doctor = settings.arguments as DoctorEntity;
        return _page(
          BlocProvider(
            create: (context) => sl<GetXDoctorCubit>()..getXDoctor(doctor.id),
            child: DoctorScreen(doctor: doctor),
          ),
          name: Routes.doctor,
        );
      case Routes.clinic:
        final clinic = settings.arguments as ClinicEntity;
        return _page(
          BlocProvider(
            create: (_) =>
                sl<GetXClinicCubit>()..getXClinic(clinicId: clinic.id),
            child: ClinicScreen(clinic: clinic),
          ),
          name: Routes.clinic,
        );
      case Routes.bookDoctor:
        final BookDoctorScreenArgs args =
            settings.arguments as BookDoctorScreenArgs;
        return _page(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    sl<GetDoctorAvailabilityCubit>()
                      ..getDoctorAvailability(args.doctor.id),
              ),
              BlocProvider(create: (c) => sl<CreateBookingCubit>()),
            ],
            child: BookDoctorScreen(args: args),
          ),
          name: Routes.bookDoctor,
        );

      case Routes.filters:
        final args = settings.arguments as FilterScreenArgs;
        return _page(
          BlocProvider(
            create: (_) => FiltersCubit(args.allFilters, args.initialFilters),
            child: const FiltersScreen(),
          ),
          name: Routes.filters,
        );
      case Routes.bookingDetails:
        return _page(const MyBookingDetailsScreen(), name: Routes.bookingDetails);

      case Routes.cancelBooking :
        final booking = settings.arguments as BookingEntity ;
        return _page( BlocProvider(
            create: (c)=>sl<CancelBookingCubit>(),
            child: CancelBookingScreen(booking: booking,)), name: Routes.cancelBooking) ;
        case Routes.rescheduleBooking :
        final booking = settings.arguments as BookingEntity ;
        return _page( MultiBlocProvider(
          providers: [
          BlocProvider(
          create: (c)=>sl<ChangeBookingDateCubit>(),) ,
           BlocProvider(create:(c)=> sl<GetDoctorAvailabilityCubit>()..getDoctorAvailability(booking.doctor.id))
          ],
              child: RescheduleBookingScreen(booking: booking,),
        ), name: Routes.rescheduleBooking) ;
      case Routes.result:
        final args = settings.arguments as ResultScreenArgs;
        return _page(ResultScreen(args: args));
      case Routes.rateBooking :
        final booking  = settings.arguments as BookingEntity ;
        return _page(ReviewBookingScreen(booking: booking), name: Routes.rateBooking);
      default:
        return null;
    }
  }

  MaterialPageRoute _page(Widget child, {String? name}) => MaterialPageRoute(
    builder: (_) => child,
    settings: RouteSettings(name: name),
  );
}
