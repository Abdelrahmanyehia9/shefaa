import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/services/navigation_service.dart';
import 'package:shefaa/core/utils/app_configs.dart';
import 'package:shefaa/features/location/presentation/view/add_location_screen.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';
import 'package:shefaa/shared/presentation/controllers/user_session_cubit.dart';
import 'package:shefaa/shared/presentation/controllers/user_session_states.dart';
import 'package:shefaa/shared/presentation/view/result_screen.dart';

class UserSessionListener extends StatefulWidget {
  final Widget child;

  const UserSessionListener({super.key, required this.child});

  @override
  State<UserSessionListener> createState() => _UserSessionListenerState();
}

class _UserSessionListenerState extends State<UserSessionListener> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserSessionCubit, UserSessionStates>(
      listener: (context, state) {
        if (state is UserSessionFreshUser) {
          _go(Routes.onboarding);
        } else if (state is UserSessionSignIn) {
          if (state.user.role != AppConfigs.appRole) {
            _go(
              Routes.result,
              args: ResultScreenArgs(
                type: ResultType.error404,
                message:
                    'مرحبا يا دكتور، يبدو أنك في المكان الخطأ. هذا التطبيق خاص بالمرضى.',
                footer: (c) => Column(
                  spacing: UISizes.h12,
                  children: [
                    AppButton.filled("الى تطبيق الاطباء"),
                    AppButton.text(
                      "تسجيل الخروج",
                      textColor: c.colors.primary,
                      style: c.textTheme.labelMedium,
                      onTap: sessionCubit.signOut,
                      align: Alignment.center,
                    ),
                  ],
                ),
              ),
            );
          }
          else if (!state.user.isCompleteUser) {
            _go(Routes.completeProfile, args: state.user);
          } else if (state.user.selectedLocation == null &&
              !state.skipLocation) {
            final args = AddLocationScreenArgs(
              onSkip: sessionCubit.skipLocation,
              onLocationAddedSuccess: (_) => sessionCubit.skipLocation(),
            );
            _go(Routes.addLocation, args: args);
          } else {
            _go(Routes.shell);
          }
        } else if (state is UserSessionGuest) {
          _go(Routes.shell);
        }
      },
      child: widget.child,
    );
  }

  void _go(String route, {Object? args}) {
    if (!mounted || _isNavigating) return;
    _isNavigating = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      NavigationService.navigator?.pushNamedAndRemoveUntil(
        route,
        (_) => false,
        arguments: args,
      );

      _isNavigating = false;
    });
  }
}
