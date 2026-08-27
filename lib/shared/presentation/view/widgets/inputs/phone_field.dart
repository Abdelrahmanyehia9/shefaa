import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/app_validation.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class PhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<Country>? onCountryChange;
  final Country initialCountry;
  final bool readOnly;

  const PhoneField({
    super.key,
    this.controller,
    required this.initialCountry,
    this.onCountryChange,
    this.readOnly = false,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late final ValueNotifier<Country> _country;

  @override
  void initState() {
    super.initState();
    _country = ValueNotifier(widget.initialCountry);
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = context.isRTL;
    return ValueListenableBuilder<Country>(
      valueListenable: _country,
      builder: (_, country, _) => AppTextField(
        labelText: "رقم الهاتف",
        readOnly: widget.readOnly,
        controller: widget.controller,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        validator: (val) =>
            AppValidation.validateNumber(val, country.example.length),
        padding: EdgeInsets.zero,
        keyboardType: TextInputType.phone,
        formatter: [FilteringTextInputFormatter.digitsOnly],
        prefix: !isRtl ? _countrySelector(country) : null,
        suffix: isRtl ? _countrySelector(country) : null,
      ),
    );
  }

  Widget _countrySelector(Country country) => _CountryCodePrefix(
    country,
    onSelect: (value) {
      if (value == country) return;
      _country.value = value;
      widget.onCountryChange?.call(value);
    },
  );
  @override
  void dispose() {
    _country.dispose();
    super.dispose();
  }
}

class _CountryCodePrefix extends StatelessWidget {
  final Country country;
  final ValueChanged<Country> onSelect;
  const _CountryCodePrefix(this.country, {required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AppChip(
        color: Colors.transparent,
        paddingHr: UISizes.w16,
        paddingVr: UISizes.h16,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: UISizes.w8,
          children: [
            AppClick(
              onTap: () => _openCountryPicker(context),
              child: AppIconText(
                icon: AppIcons.arrowDown,
                iconSize: UISizes.sp16,
                customText: CountryFlag.fromCountryCode(
                  country.countryCode,
                  theme: ImageTheme(width: UISizes.w24, height: UISizes.h16),
                ),
              ),
            ),
            AppText(
              '+${country.phoneCode}',
              height: 0,
              style: context.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _openCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showDragHandle: false,
      customFlagBuilder: (country) => Row(
        spacing: UISizes.w8,
        children: [
          CountryFlag.fromCountryCode(country.countryCode),
          AppText("[+${country.phoneCode}]"),
        ],
      ),
      onSelect: onSelect,
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText("اختار الدولة", style: context.textTheme.headlineMedium),

          IconButton(onPressed: context.pop, icon: const Icon(AppIcons.close)),
        ],
      ),
      countryListTheme: CountryListThemeData(
        backgroundColor: context.colors.surface,
        bottomSheetHeight: context.height * .8,
        textStyle: context.textTheme.bodyLarge,
        padding: EdgeInsets.zero,
        inputDecoration: InputDecoration(
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(),
          hintText: "البحث",
          hintStyle: context.textTheme.labelMedium,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: context.colors.primary),
          ),
        ),
      ),
    );
  }
}
