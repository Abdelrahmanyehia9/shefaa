import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/enum/gender.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class GenderSelector extends StatefulWidget {
  final Gender gender;
  final ValueChanged<Gender> onChanged;
  const GenderSelector({
    super.key,
    required this.gender,
    required this.onChanged,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late final ValueNotifier<Gender> _genderNotifier;

  @override
  void initState() {
    _genderNotifier = ValueNotifier(widget.gender);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final genders = Gender.values;
    return Column(
      children: [
        const SectionHeader(title: "النوع", paddingVr: 0),
        ValueListenableBuilder(
          valueListenable: _genderNotifier,
          builder: (context, value, _) {
            return Row(
              spacing: UISizes.w12,
              children: genders
                  .map(
                    (e) => Expanded(
                      child: _item(
                        gender: e,
                        isSelected: value == e,
                        onTap: () {
                          if (e == value) return;
                          _genderNotifier.value = e;
                          widget.onChanged.call(e);
                        },
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _item({
    required Gender gender,
    required bool isSelected,
    VoidCallback? onTap,
  }) => AppChip(
    onTap: onTap,
    monochromatic: !isSelected,
    height: UISizes.sp48,
    child: AppIconText(
      mainAxisAlignment: MainAxisAlignment.center,
      color: isSelected ? context.colors.onPrimary : context.colors.primary,
      icon: gender.icon,
      textStyle: context.textTheme.labelLarge,
      iconSize: UISizes.sp24,
      text: gender.text,
    ),
  );

  @override
  void dispose() {
    _genderNotifier.dispose();
    super.dispose();
  }
}
