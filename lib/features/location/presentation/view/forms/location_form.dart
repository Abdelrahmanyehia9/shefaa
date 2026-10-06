import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/app_validation.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class LocationForm extends StatelessWidget {
  const LocationForm({
    super.key,
    this.formKey,
    this.governorateController,
    this.areaController,
    this.streetController,
    this.buildingController,
    this.apartmentController,
    this.floorController,
    this.addressNameController,
  });

  final GlobalKey<FormState>? formKey;

  final TextEditingController? governorateController;
  final TextEditingController? areaController;
  final TextEditingController? streetController;
  final TextEditingController? buildingController;
  final TextEditingController? apartmentController;
  final TextEditingController? floorController;
  final TextEditingController? addressNameController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: UISizes.h4,
        children: [
          Row(
            spacing: UISizes.w8,
            children: [
              Expanded(
                child: _field(
                  context: context,
                  header: "المحافظة",
                  hint: "مثال: القاهرة",
                  controller: governorateController,
                ),
              ),
              Expanded(
                child: _field(
                  context: context,
                  header: "المنطقة",
                  hint: "مثال: مدينة نصر",
                  controller: areaController,
                ),
              ),
            ],
          ),

          _field(
            context: context,
            header: "اسم الشارع",
            hint: "مثال: شارع عباس العقاد",
            controller: streetController,
          ),

          Row(
            spacing: UISizes.w4,
            children: [
              Expanded(
                child: _field(
                  context: context,
                  header: "المبنى",
                  hint: "مثال: 23 أ",
                  controller: buildingController,
                ),
              ),
              Expanded(
                child: _field(
                  context: context,
                  header: "الشقة",
                  hint: "مثال: 12",
                  controller: apartmentController,
                ),
              ),
              Expanded(
                child: _field(
                  context: context,
                  header: "الطابق",
                  hint: "مثال: 3",
                  controller: floorController,
                  numeric: true,
                ),
              ),
            ],
          ),

          _field(
            context: context,
            header: "اسم العنوان",
            hint: "مثال: المنزل أو العمل",
            controller: addressNameController,
            maxLines: 2,
            isRequired: false,
          ),
        ],
      ),
    );
  }

  Widget _field({
    required BuildContext context,
    required String header,
    String? hint,
    TextEditingController? controller,
    bool isRequired = true,
    bool numeric = false,
    int maxLines =1
  }) {
    final Widget customHeader = AppIconText(
      text: isRequired ? "*" : null,
      gap: 0,
      textSize: UISizes.sp16,
      color: context.colors.error,
      customIcon: AppText(
        header,
        style: context.textTheme.titleSmall,
      ),
    ).appPaddingAll(4);

    return AppTextField(
      controller: controller,
      maxLines: maxLines,
      customHeader: customHeader,
      hintText: hint,
      hintStyle: context.textTheme.labelMedium?.copyWith(
        color: context.colors.surfaceContainerLow,
      ),
      validator: isRequired ? AppValidation.validateRequired : null,
      formatter: [
        if (numeric) FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: numeric ? TextInputType.number : null,
    );
  }
}