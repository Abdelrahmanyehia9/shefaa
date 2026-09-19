import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/domain/entity/booking_options_entity.dart';
import 'package:shefaa/features/booking/presentation/controller/booking_schedule_controller.dart';
import 'package:shefaa/features/booking/presentation/controller/booking_validator.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_cubit.dart';
import 'package:shefaa/features/booking/presentation/controller/patient_form_controller.dart';
import 'package:shefaa/features/booking/presentation/controller/support_us_controller.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v1.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v2.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v3.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/create_booking_consumer.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_back_button.dart';

part 'widgets/book_doctor_appbar.dart';

part 'widgets/book_doctor_action.dart';

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

class _BookDoctorScreenState extends State<BookDoctorScreen> {
  late final PageController pageController;

  late final BookingScheduleController scheduleController;

  late final PatientFormController patient;
  late final SupportUsController supportUsController;

  late final List<Widget> forms;
  late final BookingValidator validator;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateBookingCubit>();
    pageController = PageController(initialPage: cubit.currentStep);
    scheduleController = BookingScheduleController();
    patient = PatientFormController(cubit.isSelfBooking);
    supportUsController = SupportUsController();
    forms = [
      BookingFormV1(
        controller: scheduleController,
        doctor: widget.args.doctor,
        clinic: widget.args.clinic,
      ),
      BookingFormV2(controller: patient),
      BookingFormV3(
        options: widget.args.options,
        controller: supportUsController,
      ),
    ];
    validator = BookingValidator(
      schedule: scheduleController,
      patient: patient,
      supportUs: supportUsController,
    );
  }

  void _syncPage(int step) {
    if (!pageController.hasClients) return;
    if (pageController.page?.round() == step) return;
    pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    validator.setStep(step);
  }

  Future<void> _createBooking() async {
    final args = widget.args;
    final request = BookingRequest(
      doctorId: args.doctor.id,
      bookingDate: scheduleController.toDateTime(),
      clinicId: args.clinic?.id,
      customPatient: patient.customPatient(),
    );
    await context.read<CreateBookingCubit>().createBooking(
      request: request,
      amount: args.options.consultFees,
      support: supportUsController.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CreateBookingConsumer(
      onInit: (_, _, state) => _syncPage(state.currentStep),
      builder: (_, cubit, state) {
        final step = state.currentStep;
        final isFirst = step == 0;
        final isLast = step == forms.length - 1;
        return PopScope(
          canPop: isFirst,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) cubit.previousStep();
          },
          child: AppScaffold(
            resizeToAvoidBottomInset: true,
            appBar: _BookDoctorAppbar(
              isFirst: isFirst,
              onBack: isFirst ? context.pop : cubit.previousStep,
              step: step,
              totalSteps: forms.length,
            ),
            body: Column(
              spacing: UISizes.h16,
              children: [
                Gap.medium(),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.none,
                    children: forms,
                  ),
                ),
                _BookDoctorAction(
                  validation: validator.validationMessage,
                  isFirst: isFirst,
                  isLast: isLast,
                  onNext: isLast ? _createBooking : cubit.nextStep,
                  onPrevious: cubit.previousStep,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    scheduleController.dispose();
    patient.dispose();
    supportUsController.dispose();
    validator.dispose() ;
    super.dispose();
  }
}
