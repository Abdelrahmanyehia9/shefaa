import 'package:flutter/material.dart';
import 'package:shefaa/shared/data/models/phone_number.dart';
import 'package:shefaa/shared/presentation/view/widgets/inputs/phone_field.dart';

class BookingPatientContact extends StatefulWidget {
  final PhoneNumber phone;
  const BookingPatientContact({super.key, required this.phone});

  @override
  State<BookingPatientContact> createState() => _BookingPatientContactState();
}

class _BookingPatientContactState extends State<BookingPatientContact> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(text: widget.phone.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneField(
      initialCountry: widget.phone.country,
      controller: _controller,
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
