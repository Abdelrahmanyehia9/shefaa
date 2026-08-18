import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class OtpField extends StatelessWidget {
  final PinInputController? controller;
  final void Function(String)? onComplete;
  final bool enabled;
  const OtpField({
    super.key,
    this.enabled = true,
    this.controller,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: MaterialPinField(
          onCompleted: onComplete,
          pinController: controller,
          autoFocus: true,
          enabled: enabled,
          theme: Theme.of(context).materialPinTheme?.copyWith(
            cellSize: Size(UISizes.w48, UISizes.h64),
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          length: 6,
          separatorBuilder: (context, position) => const HGap(8),
        ),
      ),
    );
  }
}
