import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_loader.dart';
import 'package:shefaa/core/routing/app_router.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/services/navigation_service.dart';
import 'package:shefaa/core/theme/app_scroll_behavior.dart';
import 'package:shefaa/core/theme/app_theme.dart';

class ShefaaApp extends StatelessWidget {
  final AppRouter router;

  const ShefaaApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          scrollBehavior: AppScrollBehavior(),
          onGenerateRoute: router.generateRoute,
          initialRoute: Routes.signIn,
          theme: AppTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
          darkTheme: AppTheme.darkTheme(),
          builder: (context, routerChild) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: GlobalLoaderOverlay(
                  overlayWidgetBuilder: (_) => const AppLoader(),
                  overlayColor: Colors.black54,
                  child: routerChild!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
