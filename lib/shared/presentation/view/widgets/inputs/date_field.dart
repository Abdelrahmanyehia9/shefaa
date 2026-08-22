import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class DateField extends StatefulWidget {
  final String? label;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onChanged;

  const DateField({super.key, this.initialDate, this.onChanged, this.label});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.initialDate;
    _dateController.text = widget.initialDate?.toBirthDateForm() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      onTap: () async {
        final date = await DatePicker.showSimpleDatePicker(
          context,
          titleText: "اختر التاريخ",
          itemTextStyle: context.textTheme.bodyLarge,
          cancelText: "الغاء",
          confirmText: "تاكيد",
          looping: true,
          dateFormat: "dd-MMMM-yyyy",
          lastDate: DateTime.now().subtract(const Duration(days: 4380)),
          initialDate:
              _selectedDate ??
              DateTime.now().subtract(const Duration(days: 6570)),
        );
        if (date != null && date != widget.initialDate) {
          _dateController.text = date.toBirthDateForm();
          _selectedDate = date;
          widget.onChanged?.call(_selectedDate!);
        }
      },
      controller: _dateController,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: widget.label ?? " تاريخ الميلاد",
      readOnly: true,
      suffix: Icon(AppIcons.calender, size: UISizes.sp28),
    );
  }
}
