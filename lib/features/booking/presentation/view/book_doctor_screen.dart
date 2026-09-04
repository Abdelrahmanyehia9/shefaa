import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/booking/domain/entity/booking_options_entity.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v1.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v2.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v3.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/shared/presentation/mixin/page_controller_mixin.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_back_button.dart';
final class BookDoctorScreenArgs{
  final DoctorEntity doctor ;
  final  ClinicEntity? clinic ;
  final BookingOptionsEntity options ;
  const BookDoctorScreenArgs({required this.doctor, this.clinic, required this.options});
}



class BookDoctorScreen extends StatefulWidget {
  final BookDoctorScreenArgs args ;
  const BookDoctorScreen({super.key, required this.args});

  @override
  State<BookDoctorScreen> createState() => _BookDoctorScreenState();
}

class _BookDoctorScreenState extends State<BookDoctorScreen>
    with PageControllerMixin {
  late final List<Widget> forms ;
  int _currentIndex = 0;

  @override
  void initState() {
     forms = [
      BookingFormV1(doctor: widget.args.doctor,clinic: widget.args.clinic,),
      const BookingFormV2(),
      const BookingFormV3(),
    ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isFirst,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (!isFirst) {
          prev();
        }
      },
      child: AppScaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: AppBackButton(
            onBack: () {
              if (isFirst) {
                Navigator.pop(context);
              } else {
                prev();
              }
            },
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
                clipBehavior: Clip.none,
                controller: pageController,
                itemCount: forms.length,
                itemBuilder: (_, i) => forms[i],
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentIndex = i),
              ),
            ),
            Row(
              spacing: UISizes.w8,
              children: [
                Expanded(
                  child: AppButton.filled(
                    isLast ? "تأكيد الحجز" : "التالي",
                    onTap: next,
                  ),
                ),
                if (!isFirst)
                  Expanded(
                    child: AppButton.outlined(
                      "السابق",
                      onTap: prev,
                      color: context.colors.primary,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  int get currentIndex => _currentIndex;

  @override
  void onFinish() {}

  @override
  int get pagesLength => forms.length;
}
