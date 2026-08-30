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
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = ValueNotifier(widget.initialIndex);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onChanged(int index) {
    if (index == _selectedIndex.value) return;

    _selectedIndex.value = index;
    widget.onChanged?.call(index);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Scrollable.ensureVisible(
        _itemKeys[index].currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        alignment: 0.5,
      );
    });
  }

  final List<GlobalKey> _itemKeys = [];

  @override
  Widget build(BuildContext context) {
    if (_itemKeys.length != widget.itemCount) {
      _itemKeys
        ..clear()
        ..addAll(List.generate(widget.itemCount, (_) => GlobalKey()));
    }

    return SizedBox(
      height: widget.height ?? UISizes.h40,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, selectedIndex, _) {
          return ListView.separated(
            controller: _scrollController,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: widget.itemCount,
            separatorBuilder: (_, _) => HGap.small(),
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;

              return KeyedSubtree(
                key: _itemKeys[index],
                child: AppChip(
                  width: widget.width,
                  alignment: Alignment.center,
                  radius: widget.radius,
                  onTap: () => _onChanged(index),
                  paddingHr: widget.paddingHr ?? UISizes.w12,
                  paddingVr: widget.paddingVr,
                  borderColor: isSelected
                      ? context.colors.primary
                      : context.colors.surfaceContainerLowest,
                  color: isSelected
                      ? context.colors.primary
                      : Colors.transparent,
                  child: widget.itemBuilder(context, index, isSelected),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
