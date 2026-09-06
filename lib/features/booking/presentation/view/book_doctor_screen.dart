import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_options_entity.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_cubit.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v1.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v2.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v3.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/shared/presentation/mixin/page_controller_mixin.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_back_button.dart';

final class BookDoctorScreenArgs {
  final DoctorEntity doctor;
  final ClinicEntity? clinic;
  final BookingOptionsEntity options;

  const BookDoctorScreenArgs({
    required this.doctor,
    this.clinic,
    required this.options,
  });
}

class BookDoctorScreen extends StatefulWidget {
  final BookDoctorScreenArgs args;

  const BookDoctorScreen({super.key, required this.args});

  @override
  State<BookDoctorScreen> createState() => _BookDoctorScreenState();
}

class _BookDoctorScreenState extends State<BookDoctorScreen>
    with PageControllerMixin {
  CreateBookingCubit get cubit => context.read<CreateBookingCubit>();

  late final List<Widget> forms;

  @override
  void initState() {
    super.initState();

    forms = [
      BookingFormV1(doctor: widget.args.doctor, clinic: widget.args.clinic),
      const BookingFormV2(),
      const BookingFormV3(),
    ];
  }

  void _goPrev() {
    prev();
    cubit.setStep(currentIndex);
  }

  void _goNext() {
    if (cubit.validator.validationMessage.value != null) return;
    if (isLast) {
      onFinish();
      return;
    }

    next();
  }

  void _onPageChanged(int index) {
    cubit.setStep(index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isFirst,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _goPrev();
      },
      child: AppScaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: AppBackButton(
            onBack: isFirst ? () => Navigator.pop(context) : _goPrev,
          ).appPaddingAll(8),
          title: Column(
            children: [
              const AppText("حجز موعد"),
              AppText(
                "خطوة ${currentIndex + 1} من $pagesLength",
                style: context.textTheme.titleSmall,
                color: context.colors.primary,
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          spacing: UISizes.h16,
          children: [
            Gap.medium(),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: forms.length,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                itemBuilder: (_, index) => forms[index],
                onPageChanged: _onPageChanged,
              ),
            ),
            ValueListenableBuilder<String?>(
              valueListenable: cubit.validator.validationMessage,
              builder: (_, error, _) {
                return Column(
                  spacing: UISizes.h8,
                  children: [
                    Row(
                      spacing: UISizes.w8,
                      children: [
                        Expanded(
                          child: AppButton.filled(
                            isLast ? "تأكيد الحجز" : "التالي",
                            isDisabled: error != null,
                            onTap: _goNext,
                          ),
                        ),
                        if (!isFirst)
                          Expanded(
                            child: AppButton.outlined(
                              "السابق",
                              onTap: _goPrev,
                              color: context.colors.primary,
                            ),
                          ),
                      ],
                    ),
                    Visibility(
                      visible: error != null,
                      maintainState: true,
                      maintainAnimation: true,
                      maintainSize: true,
                      child: AppIconText(
                        text: error,
                        icon: AppIcons.error,
                        textStyle: context.textTheme.titleSmall,
                        color: context.colors.error,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  int get currentIndex => cubit.currentStep;

  @override
  int get pagesLength => forms.length;

  @override
  void onFinish() {
    cubit.createBooking();
  }
}
