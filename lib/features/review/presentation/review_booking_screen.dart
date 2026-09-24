import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/enum/review_type.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_clinic_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_doctor_info.dart';
import 'package:shefaa/features/review/presentation/controller/review_booking_cubit.dart';
import 'package:shefaa/features/review/presentation/controller/review_controller.dart';
import 'package:shefaa/features/review/presentation/widgets/review_item.dart';
import 'package:shefaa/shared/presentation/mixin/page_controller_mixin.dart';
import 'package:shefaa/shared/presentation/view/result_screen.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_back_button.dart';


class ReviewBookingScreen extends StatefulWidget {
  final BookingEntity booking;

  const ReviewBookingScreen({super.key, required this.booking});

  @override
  State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends State<ReviewBookingScreen>
    with PageControllerMixin {
  int _currentIndex = 0;
  late final Map<ReviewType, ReviewController> controllers;
  late final List<Widget> forms;

  ReviewBookingCubit get reviewCubit => context.read<ReviewBookingCubit>();

  @override
  void initState() {
    super.initState();
    final booking = widget.booking;
    controllers = {
      ReviewType.doctor: ReviewController(),
      if (booking.clinic != null)
        ReviewType.clinic: ReviewController(),
      ReviewType.staff: ReviewController(),
    };
    forms = [
      ReviewItem(
        controller: controllers[ReviewType.doctor]!,
        header: BookingDoctorInfo(doctor: booking.doctor),
        question: booking.doctor.name,
      ),
      if (booking.clinic != null)
        ReviewItem(
          controller: controllers[ReviewType.clinic]!,
          header: BookingClinicInfo(clinic: booking.clinic!),
          question: booking.clinic!.name,
          canMediaUpload: true,
        ),
      ReviewItem(
        controller: controllers[ReviewType.staff]!,
        question: "الممرضين والمساعدين",
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    final currentRateType = controllers.keys.elementAt(_currentIndex);
    return BaseBlocConsumer(
      onLoading: context.loaderOverlay.show,
      onLoaded: (s) {
        context.loaderOverlay.hide();
        if (s.isFailure) _showResult(type: ResultType.error404, message: s.error?.message) ; 
        if(s.isSuccess) _showResult(type: ResultType.success,message: "تم إرسال تقييمك بنجاح، شكرًا لمشاركتنا رأيك. ملاحظاتك تساعدنا على تحسين تجربتك وتقديم خدمة أفضل لك.") ;
      },
      bloc: reviewCubit,
      builder: (s) =>
          PopScope(
            canPop: isFirst,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) prev();
            },
            child: AppScaffold(
              hPadding: 0,
              appBar: AppBar(
                leading: AppBackButton(onBack: isFirst ? context.pop : prev)
                    .appPaddingAll(10),
                title: Column(
                  children: [
                    const AppText("تقييم الاستشارة"),
                    AppText("تقييم ${currentRateType.text}  ${_currentIndex +
                        1}من ${forms.length}",
                      color: context.colors.surfaceContainer,
                      style: context.textTheme.labelSmall,
                    )
                  ],
                ),

              ),
              body: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index) =>
                          setState(() => _currentIndex = index),
                      controller: pageController,
                      itemCount: forms.length,
                      itemBuilder: (context, i) => forms[i].paddingHr,
                    ),
                  ),
                  Column(
                    spacing: UISizes.h12,
                    children: [
                      AppButton.filled(
                        isLast ? "تاكيد" : "التالى", onTap: next,),
                      if(!isFirst)
                        AppButton.outlined(
                          "السابق", color: context.colors.primary,
                          onTap: prev,
                        )
                    ],
                  ).paddingHr
                ],
              ),
            ),
          ),
    );
  }

  @override
  int get currentIndex => _currentIndex;

  @override
  void onFinish() {
    reviewCubit.giveReview(widget.booking, controllers);
  }

  @override
  int get pagesLength => forms.length;

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _showResult({required ResultType type, String? message}) {
    context.pushNamedAndRemoveUntil(
        Routes.result, arguments: ResultScreenArgs(type: type, 
        message: message,
        footer: (context)=>AppButton.filled("الرئيسية", 
        onTap: ()=>context.pushNamedAndRemoveUntil(Routes.shell),
        
        ))); 
  }
}