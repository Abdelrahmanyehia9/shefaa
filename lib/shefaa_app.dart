import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_loader.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/routing/app_router.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/services/navigation_service.dart';
import 'package:shefaa/core/theme/app_scroll_behavior.dart';
import 'package:shefaa/core/theme/app_theme.dart';
import 'package:shefaa/shared/presentation/view/widgets/user_session_builder.dart';

class ShefaaApp extends StatelessWidget {
  final AppRouter router;

  const ShefaaApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return MultiBlocProvider(
          providers: [BlocProvider.value(value: sessionCubit)],
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            scrollBehavior: AppScrollBehavior(),
            onGenerateRoute: router.generateRoute,
            initialRoute: Routes.shell,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            debugShowCheckedModeBanner: false,
            builder: (context, routerChild) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: GlobalLoaderOverlay(
                overlayWidgetBuilder: (_) => const AppLoader(),
                overlayColor: Colors.black54,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: UserSessionBuilder(child: routerChild!),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
