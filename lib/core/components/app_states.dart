import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_svg.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/utils/app_assets.dart' show AppAssets;

enum States {
  error404,
  comingSoon,
  noConnection,
  noNotification,
  noPaymentMethod,
  noResult,
  scheduled,
  success,
  visitScheduled,
  gotBonus;

  String get image => switch (this) {

    error404 => AppAssets.illustration404,
    comingSoon => AppAssets.illustrationComingSoon,
    noConnection => AppAssets.illustrationNoConnection,
    noNotification => AppAssets.illustrationNoNotification,
    noPaymentMethod => AppAssets.illustrationNoPaymentMethod,
    noResult => AppAssets.illustrationNoResult,
    scheduled => AppAssets.illustrationScheduled,
    success => AppAssets.illustrationSuccess,
    visitScheduled => AppAssets.illustrationVisitScheduled,
    gotBonus => AppAssets.illustrationGotBonus,
  };

  String get title => switch (this) {
    error404 => 'الصفحة غير موجودة',
    comingSoon => 'قريبًا',
    noConnection => 'لا يوجد اتصال',
    noNotification => 'لا توجد إشعارات',
    noPaymentMethod => 'لا توجد طريقة دفع',
    noResult => 'لا توجد نتائج',
    scheduled => 'تمت الجدولة',
    success => 'تمت العملية بنجاح',
    visitScheduled => 'تم جدولة الزيارة',
    gotBonus => 'لقد حصلت على مكافأة',
  };

  String get description => switch (this) {
    error404 => 'الصفحة التي تبحث عنها غير موجودة',
    comingSoon => 'هذه الميزة ستكون متاحة قريبًا',
    noConnection => 'تحقق من اتصالك بالإنترنت وحاول مرة أخرى',
    noNotification => 'ليس لديك أي إشعارات في الوقت الحالي',
    noPaymentMethod => 'لم تقم بإضافة أي طريقة دفع حتى الآن',
    noResult => 'لم نتمكن من العثور على نتائج مطابقة',
    scheduled => 'تم جدولة موعدك بنجاح',
    success => 'تمت العملية بنجاح',
    visitScheduled => 'تم جدولة زيارتك بنجاح',
    gotBonus => 'لقد حصلت على مكافأة جديدة',
  };
}

class AppStates extends StatelessWidget {
  final States state;
  final double size;
  final Widget? customIcon;
  final String? customSvg;
  final String? message;
  final Widget? footer ;
  final MainAxisAlignment? mainAxisAlignment ;
  const AppStates({
    super.key,
    this.footer,
    this.customIcon,
    this.customSvg,
    this.size = 20,
    this.message,
    required this.state,
    this.mainAxisAlignment
  });

  factory AppStates.error(
      AppException e, {
        double size = 20,
        Widget? customIcon,
        String? customSvg,
        Widget? footer,
        MainAxisAlignment? mainAxisAlignment
      }) => AppStates(
    state: States.error404,
    message: e.message,
    customIcon: customIcon,
    customSvg: customSvg,
    size: size,
    footer: footer,
    mainAxisAlignment: mainAxisAlignment,
  );

  factory AppStates.empty({
    double size = 20,
    Widget? customIcon,
    String? customSvg,
    Widget? footer,
    String? message,
    MainAxisAlignment? mainAxisAlignment

  }) => AppStates(
    state: States.noResult,
    customIcon: customIcon,
    customSvg: customSvg,
    size: size,
    message: message,
    footer: footer,
    mainAxisAlignment: mainAxisAlignment,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: size*.1,
        mainAxisAlignment: mainAxisAlignment?? MainAxisAlignment.center,
        children: [
          _buildImage(context).animate().shimmer(
            duration: 500.ms,
          ),
          AppText(
            message?? state.description,
            style: context.textTheme.labelLarge,
                fontSize: size *.7,
                height: 0,
                color: context.colors.surfaceContainer,
            textAlign: TextAlign.center,
            ),
         ?footer,
        ],
      ).appPaddingAll(size),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (customIcon != null) {
      return customIcon! ;
    }
    return Transform.scale(
      scale: 1.2,
      child: AppSvg.asset(
        customSvg ?? state.image,
        height: (size *7.5),
        fit: BoxFit.cover,

      ),
    );
  }
}