import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class AppFiltersGrid extends StatefulWidget {
  const AppFiltersGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.childAspectRatio,
    this.initialIndexes = const [],
    this.onChanged,
    this.isDisabled,
    this.paddingHr,
    this.paddingVr,
    this.radius,
    this.width,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.crossAxisCount = 3,
    this.height,
    this.multiSelection = false,
  });

  final int itemCount;

  final List<int> initialIndexes;
  final ValueChanged<List<int>>? onChanged;

  final bool Function(int index)? isDisabled;

  final double? width;
  final double? paddingHr;
  final double? paddingVr;
  final double? radius;

  final double childAspectRatio;

  final double? mainAxisSpacing;
  final double? crossAxisSpacing;

  final int crossAxisCount;
  final double? height;

  final bool multiSelection;

  final Widget Function(
    BuildContext context,
    int index,
    bool isSelected,
    bool isDisabled,
  )
  itemBuilder;

  @override
  State<AppFiltersGrid> createState() => _AppFiltersGridState();
}

class _AppFiltersGridState extends State<AppFiltersGrid> {
  late final ValueNotifier<Set<int>> _selectedIndexes;

  @override
  void initState() {
    super.initState();

    _selectedIndexes = ValueNotifier(widget.initialIndexes.toSet());
  }

  @override
  void didUpdateWidget(covariant AppFiltersGrid oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialIndexes != widget.initialIndexes) {
      _selectedIndexes.value = widget.initialIndexes.toSet();
    }
  }

  @override
  void dispose() {
    _selectedIndexes.dispose();
    super.dispose();
  }

  void _onChanged(int index) {
    if (widget.isDisabled?.call(index) ?? false) {
      return;
    }

    final selectedIndexes = Set<int>.from(_selectedIndexes.value);

    if (widget.multiSelection) {
      // "الكل"
      if (index == 0) {
        selectedIndexes.clear();
      } else {
        if (selectedIndexes.contains(index)) {
          selectedIndexes.remove(index);
        } else {
          selectedIndexes.add(index);
        }
      }
    } else {
      if (selectedIndexes.contains(index)) {
        return;
      }

      selectedIndexes
        ..clear()
        ..add(index);
    }

    _selectedIndexes.value = selectedIndexes;

    widget.onChanged?.call(selectedIndexes.toList());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ValueListenableBuilder<Set<int>>(
        valueListenable: _selectedIndexes,
        builder: (context, selectedIndexes, _) {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: widget.itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              childAspectRatio: widget.childAspectRatio,
              mainAxisSpacing: widget.mainAxisSpacing ?? UISizes.w8,
              crossAxisSpacing: widget.crossAxisSpacing ?? UISizes.h8,
            ),
            itemBuilder: (context, index) {
              final isSelected = widget.multiSelection
                  ? selectedIndexes.contains(index)
                  : selectedIndexes.contains(index);

              final isDisabled = widget.isDisabled?.call(index) ?? false;

              return AppChip(
                alignment: Alignment.center,
                width: widget.width,
                radius: widget.radius,
                onTap: isDisabled ? null : () => _onChanged(index),
                paddingHr: widget.paddingHr ?? UISizes.w12,
                paddingVr: widget.paddingVr,
                borderColor: isSelected
                    ? context.colors.primary
                    : isDisabled
                    ? null
                    : context.colors.surfaceContainerLow,
                color: isSelected
                    ? context.colors.primary
                    : isDisabled
                    ? context.colors.surfaceContainerLowest
                    : Colors.transparent,
                child: widget.itemBuilder(
                  context,
                  index,
                  isSelected,
                  isDisabled,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
