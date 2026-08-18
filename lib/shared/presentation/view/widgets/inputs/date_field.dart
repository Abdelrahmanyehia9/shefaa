import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class DateField extends StatefulWidget {
  final String? label;
  final DateTime? initialDate;
  const DateField({super.key, this.initialDate, this.label});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    _dateController.text = widget.initialDate?.toBirthDateForm() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _dateController,
      labelText: widget.label ?? " تاريخ الميلاد",
      readOnly: true,
      suffix: Icon(AppIcons.calender, size: UISizes.sp28),
    );
  }
}
