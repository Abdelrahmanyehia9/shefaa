import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/local_time.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/presentation/controller/booking_schedule_controller.dart';
import 'package:shefaa/features/booking/presentation/controller/booking_validator.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v1.dart';

class RescheduleBottomSheet extends StatefulWidget {
  final DateTime time;

  const RescheduleBottomSheet({super.key, required this.time});

  @override
  State<RescheduleBottomSheet> createState() => _RescheduleBottomSheetState();
}

class _RescheduleBottomSheetState extends State<RescheduleBottomSheet> {
  late final BookingScheduleController _controller;
  late final BookingValidator _validator;

  @override
  void initState() {
    _controller = BookingScheduleController(
      selectedDate: widget.time,
      selectedTime: LocalTime(
        hour: widget.time.hour,
        minute: widget.time.minute,
      ),
    );
    _validator = BookingValidator(schedule: _controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText("تغير الميعاد", style: context.textTheme.titleLarge),
        AnimatedBuilder(
          animation: _controller,
          builder: (_, _) => AppText(
            "الميعاد المختار : ${_controller.toDateTime().toTimeAndDate(locale: "AR")}",
            style: context.textTheme.bodyLarge,
            color: context.colors.surfaceContainer,
          ),
        ),
        BookingFormV1(controller: _controller),
        Gap.medium(),
        ValueListenableBuilder(
          valueListenable: _validator.validationMessage,
          builder: (context, value, child) {
            return Column(
              spacing: UISizes.h4,
              children: [
                Row(
                  spacing: UISizes.w8,
                  children: [
                    Expanded(
                      child: AppButton.filled(
                        isDisabled: value != null,
                        "تاكيد",
                        onTap: () => context.pop(_controller.toDateTime()),
                      ),
                    ),
                    child!
                  ],
                ),
                Visibility(
                  visible: value != null,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: AppIconText(
                    text: value,
                    icon: AppIcons.error,
                    iconSize: UISizes.sp16,
                    textStyle: context.textTheme.titleSmall,
                    color: context.colors.error,
                  ),
                ),
              ],
            );
          },
          child: Expanded(
            child: AppButton.outlined(
              "الغاء",
              color: context.colors.primary,
              onTap: context.pop,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
