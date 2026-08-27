import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({super.key});

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      children: [
        _item(context, "الاسم الكامل", value: "احمد حسام"),
        _item(
          context,
          "العمر",
          child: Row(
            spacing: UISizes.w8,
            children: [
              AppText("24 سنه", style: context.textTheme.labelLarge),
              AppText(
                "(${DateTime(2002, 3, 9).toBirthDateForm(locale: "AR")})",
                style: context.textTheme.titleSmall,
                color: context.colors.primary,
              ),
            ],
          ),
        ),
        _item(context, "الجنس", value: Gender.male.text),
        _item(context, "الهاتف", value: "+201501634466"),
      ],
    ).paddingAll,
  );

  Widget _item(
    BuildContext context,
    String title, {
    String? value,
    Widget? child,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AppText(
        "$title :",
        style: context.textTheme.titleSmall,
        color: context.colors.surfaceContainer,
      ),
      child ?? AppText(value, style: context.textTheme.labelLarge),
    ],
  );
}
