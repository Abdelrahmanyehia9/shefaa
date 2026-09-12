import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class PatientCard extends StatefulWidget {
  const PatientCard({super.key});

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {

  @override
  Widget build(BuildContext context) {
    final currentUser= sessionCubit.currentUser;
    return Card(
      child: Column(
        children: [
          _item(context, "الاسم الكامل", value: currentUser?.completeName),
          _item(
            context,
            "العمر",
            child:currentUser?.dob == null ? null :  Row(
              spacing: UISizes.w8,
              children: [
                AppText("${currentUser?.dob!.ageInYear} سنه", style: context.textTheme.labelLarge),
                AppText(
                  "(${currentUser?.dob?.toBirthDateForm(locale: "AR")})",
                  style: context.textTheme.titleSmall,
                  color: context.colors.primary,
                ),
              ],
            ),
          ),
          _item(context, "الجنس", value: currentUser?.gender.text),
          _item(context, "الهاتف", value: currentUser?.phoneNumber?.complete),
        ],
      ).paddingAll,
    );
  }

  Widget _item(BuildContext context,
      String title, {
        String? value,
        Widget? child,
      }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            "$title :",
            style: context.textTheme.titleSmall,
            color: context.colors.surfaceContainer,
          ),
          child ?? AppText(value??"_", style: context.textTheme.labelLarge),
        ],
      );
}
