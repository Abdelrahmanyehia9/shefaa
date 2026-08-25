import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/shared/presentation/view/widgets/category_svg.dart';

class SpecialityFiltersList extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  const SpecialityFiltersList({
    super.key,
    required this.initialIndex,
    this.onChanged,
  });

  @override
  State<SpecialityFiltersList> createState() => _SpecialityFiltersListState();
}

class _SpecialityFiltersListState extends State<SpecialityFiltersList> {
  late final ValueNotifier<int> _selectedIndex;

  @override
  void initState() {
    _selectedIndex = ValueNotifier(widget.initialIndex);
    super.initState();
  }

  void onChange(int i) {
    if (i == _selectedIndex.value) return;
    _selectedIndex.value = i;
    widget.onChanged?.call(i);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, value, child) {
        return SizedBox(
          height: UISizes.h40,
          child: ListView.separated(
            clipBehavior: Clip.none,
            separatorBuilder: (_, i) => HGap.small(),
            itemCount: 8,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) =>
                _chip(value == i, context, onTap: () => onChange(i)),
          ),
        );
      },
    );
  }

  Widget _chip(bool isSelected, BuildContext context, {VoidCallback? onTap}) =>
      AppChip(
        onTap: onTap,
        paddingHr: UISizes.w12,
        borderColor: isSelected
            ? context.colors.primary
            : context.colors.surfaceContainerLowest,
        color: isSelected ? context.colors.primary : Colors.transparent,
        child: AppIconText(
          customIcon: CategorySVG(
            color: isSelected
                ? AppColors.white
                : context.colors.surfaceContainerHighest,
            size: UISizes.sp20,
          ),
          text: "تجميل",
          color: isSelected
              ? AppColors.white
              : context.colors.surfaceContainerHighest,
          textStyle: context.textTheme.labelLarge,
        ),
      );
}
