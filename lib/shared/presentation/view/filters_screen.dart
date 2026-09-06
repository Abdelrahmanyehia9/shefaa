import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_checkbox.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_radio.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/enum/docotor_level.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/features/medical/speciality/presentation/view/layout/speciality_filters_grid.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppText("التصفيات"),
        actions: [
          AppText(
            "الرجوع للافتراضى",
            style: context.textTheme.titleSmall,
            color: context.colors.primary,
          ),
        ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: UISizes.h12,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _FilterExpansionTile(
              title: "التخصص",
              initiallyExpanded: true,
              subtitle: "الجميع",
              child: SizedBox(
                height: UISizes.h148,
                child: SpecialityFiltersGrid(
                  specialities: SpecialityEntity.mock.fakeList(22),
                ),
              ),
            ),
            _FilterExpansionTile(
              title: "التقييم",
              initiallyExpanded: false,
              subtitle: "اى تقييم",
              child: AppRadio<int>(
                useListTile: false,
                value: 1,
                items: const [1, 2, 3, 4],
                itemBuilder: (val) => AppIconText(
                  icon: AppIcons.starFilled,
                  iconColor: AppColors.gold,
                  text: "$val فيما اكثر",
                  textStyle: context.textTheme.labelMedium,
                ),
              ),
            ),
            _FilterExpansionTile(
              title: "سعر الكشف",
              subtitle: "من 10 جنيه حتى 6000 حنيه",
              initiallyExpanded: false,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText("6000 حنيه"),
                      AppText("0 جنيه")
                    ],
                  ),
                  Slider(value: 0.5, onChanged: (v){},
                  padding: EdgeInsets.zero,
                    inactiveColor: context.colors.surfaceContainerLow,

                  ),
                ],
              ),
            ),
            _FilterExpansionTile(
              title: "المسافة",
              subtitle: "من 500 متر حتى 4 كيلومتر",
              initiallyExpanded: false,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText("25 كيلو"),
                      AppText("100 متر")
                    ],
                  ),
                  Slider(value: 0.5, onChanged: (v){},
                  padding: EdgeInsets.zero,
                    inactiveColor: context.colors.surfaceContainerLow,

                  ),
                ],
              ),
            ),
            _FilterExpansionTile(
              title: "لقب الدكتور",
              subtitle: "اخصائي",
              initiallyExpanded: false,
              child: Wrap(
                spacing: UISizes.w24,
                children: [
                  AppIconText(
                    customIcon: AppCheckbox(
                        borderColor: Colors.transparent,
                        value: false, onChanged: (_){}),
                    text: "الجميع",
                    textStyle: context.textTheme.labelMedium,
                  ),
                  ...DoctorLevel.values.map((e)=>AppIconText(
                    customIcon: AppCheckbox(
                        borderColor: Colors.transparent,
                        value: e == DoctorLevel.specialist, onChanged: (_){}),
                    text: e.text,
                    textStyle: context.textTheme.labelMedium,
                  ))

                ],
              ),
            ),
            _FilterExpansionTile(
              title: "رتب حسب",
              subtitle: "الافتراضي",
              initiallyExpanded: false,
              child: AppRadio<DoctorSortBy>(
                useListTile: false,
                value: DoctorSortBy.price,
                items: DoctorSortBy.values,
                itemBuilder: (val) => AppText(
                   val.text,
                  style: context.textTheme.labelMedium,
                ),
              ),
            ),
           Gap.small(),
           AppButton.filled("تاكيد التصفيات")

          ],
        ),
      ),
    );
  }
}

class _FilterExpansionTile extends StatelessWidget {
  final String title;

  final bool initiallyExpanded;
  final Widget child;
  final String? subtitle;

  const _FilterExpansionTile({
    required this.title,
    required this.child,
    required this.initiallyExpanded,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      subtitle: AppText(
        subtitle,
        style: context.textTheme.bodySmall,
        color: context.colors.surfaceContainer,
      ),
      initiallyExpanded: initiallyExpanded,
      title: AppText(title, style: context.textTheme.bodyLarge,),
      children: [child],
    );
  }
}
