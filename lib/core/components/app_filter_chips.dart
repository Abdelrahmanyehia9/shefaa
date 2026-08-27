import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class AppFiltersChips extends StatefulWidget {
  const AppFiltersChips({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.initialIndex = 0,
    this.onChanged,
    this.height,
    this.paddingHr,
    this.paddingVr,
    this.radius,
    this.width,
  });

  final int itemCount;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final double? height, width, paddingVr, paddingHr, radius;

  final Widget Function(BuildContext context, int index, bool isSelected)
  itemBuilder;

  @override
  State<AppFiltersChips> createState() => _AppFiltersChipsState();
}

class _AppFiltersChipsState extends State<AppFiltersChips> {
  late final ValueNotifier<int> _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = ValueNotifier(widget.initialIndex);
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  void _onChanged(int index) {
    if (index == _selectedIndex.value) return;

    _selectedIndex.value = index;
    widget.onChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? UISizes.h40,
      child: ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (context, selectedIndex, _) {
          return ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: widget.itemCount,
            separatorBuilder: (_, _) => HGap.small(),
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return AppChip(
                width: widget.width,
                alignment: Alignment.center,
                radius: widget.radius,
                onTap: () => _onChanged(index),
                paddingHr: widget.paddingHr ?? UISizes.w12,
                paddingVr: widget.paddingVr,
                borderColor: isSelected
                    ? context.colors.primary
                    : context.colors.surfaceContainerLowest,
                color: isSelected ? context.colors.primary : Colors.transparent,
                child: widget.itemBuilder(context, index, isSelected),
              );
            },
          );
        },
      ),
    );
  }
}
