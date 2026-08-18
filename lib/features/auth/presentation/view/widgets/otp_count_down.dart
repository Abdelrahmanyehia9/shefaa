import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_highlight.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/text_styles.dart';
import 'package:shefaa/features/auth/presentation/controller/otp_count_down_controller.dart';

class OtpCountDown extends StatefulWidget {
  final VoidCallback? onResend;
  final OtpCountDownController? controller;

  const OtpCountDown({super.key, this.onResend, this.controller});

  @override
  State<OtpCountDown> createState() => _OtpCountDownState();
}

class _OtpCountDownState extends State<OtpCountDown> {
  late final OtpCountDownController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? OtpCountDownController();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_controller.seconds.value == 0) {
        timer.cancel();
      } else {
        _controller.seconds.value--;
      }
    });
  }

  void _onResend() {
    if (_controller.attemptsLeft.value <= 1) {
      _controller.attemptsLeft.value = 0;
      return;
    }
    widget.onResend?.call();
    _controller.attemptsLeft.value--;
    _controller.seconds.value = 30;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        _controller.seconds,
        _controller.attemptsLeft,
      ]),
      builder: (context, _) {
        if (!_controller.hasAttemptsLeft) {
          return AppText(
            "لفد بلغت الحد الاقصي من المحاولات",
            textAlign: TextAlign.center,
            style: TextStyles.bodyMedium.copyWith(color: AppColors.error),
          );
        }

        final minutes = (_controller.seconds.value ~/ 60).toString().padLeft(
          2,
          '0',
        );
        final seconds = (_controller.seconds.value % 60).toString().padLeft(
          2,
          '0',
        );

        return _controller.isFinished
            ? Column(
                children: [
                  AppText(
                    "لم يصلك الكود",
                    height: 0,
                    textAlign: TextAlign.center,
                    color: context.colors.surfaceContainerHigh,
                    style: context.textTheme.bodyMedium,
                  ),
                  AppButton.text(
                    "اعادة الارسال",
                    align: AlignmentGeometry.center,
                    onTap: _onResend,
                    style: context.textTheme.titleMedium?.copyWith(height: 0),
                    textColor: context.colors.primary,
                  ),
                ],
              )
            : AppTextHighLight(
                "إعادة الإرسال في\t*$minutes:$seconds*",
                highlighterStyle: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.primary,
                ),
              );
      },
    );
  }
}
