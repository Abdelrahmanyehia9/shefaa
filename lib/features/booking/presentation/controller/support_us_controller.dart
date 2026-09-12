import 'package:flutter/material.dart';
import 'package:shefaa/core/utils/app_constants.dart';

class SupportUsController extends ChangeNotifier {
  static const custom = -1;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final int min;
  final int max;

  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;

  bool get isCustomSelected => _selectedIndex == custom;
  bool get hasSelection => _selectedIndex != null;

  SupportUsController({this.min = 10, this.max = 1000}) {
    amountController.addListener(notifyListeners);
  }

  int? get amount {
    if (_selectedIndex == null) return null;
    if (_selectedIndex == custom) {
      return int.tryParse(amountController.text);
    }
    return AppConstants.supportPay[_selectedIndex!];
  }

  bool get isValid {
    if (!isCustomSelected) return true;
    final value = int.tryParse(amountController.text.trim());
    if (value == null) return false;
    return value >= min && value <= max;
  }

  void select(int index) {
    _selectedIndex = _selectedIndex == index ? null : index;
    if (!isCustomSelected) amountController.clear();
    notifyListeners();
  }

  void clear() {
    _selectedIndex = null;
    amountController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    amountController.removeListener(notifyListeners);
    amountController.dispose();
    super.dispose();
  }
}