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
    this.isDisabled,
    this.height,
    this.paddingHr,
    this.paddingVr,
    this.radius,
    this.width,
  });

  final int itemCount;
  final int? initialIndex;
  final ValueChanged<int>? onChanged;

  final bool Function(int index)? isDisabled;

  final double? height;
  final double? width;
  final double? paddingVr;
  final double? paddingHr;
  final double? radius;

  final Widget Function(
      BuildContext context,
      int index,
      bool isSelected,
      bool isDisabled,
      ) itemBuilder;

  @override
  State<AppFiltersChips> createState() => _AppFiltersChipsState();
}

class _AppFiltersChipsState extends State<AppFiltersChips> {
  late final ValueNotifier<int> _selectedIndex;
  late final ScrollController _scrollController;

  final List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();

    _selectedIndex = ValueNotifier(widget.initialIndex ?? -1);
    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(covariant AppFiltersChips oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialIndex != widget.initialIndex) {
      _selectedIndex.value = widget.initialIndex ?? -1;
    }
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onChanged(int index) {
    if (widget.isDisabled?.call(index) ?? false) return;
    if (index == _selectedIndex.value) return;

    _selectedIndex.value = index;
    widget.onChanged?.call(index);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final itemContext = _itemKeys[index].currentContext;
      if (itemContext == null) return;

      Scrollable.ensureVisible(
        itemContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        alignment: 0.5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_itemKeys.length != widget.itemCount) {
      _itemKeys
        ..clear()
        ..addAll(
          List.generate(
            widget.itemCount,
                (_) => GlobalKey(),
          ),
        );
    }

    return SizedBox(
      height: widget.height ?? UISizes.h32,
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
              final isDisabled =
                  widget.isDisabled?.call(index) ?? false;
              return KeyedSubtree(
                key: _itemKeys[index],
                child: AppChip(
                  width: widget.width,
                  alignment: Alignment.center,
                  radius: widget.radius,
                  onTap: isDisabled
                      ? null
                      : () => _onChanged(index),
                  paddingHr: widget.paddingHr ?? UISizes.w12,
                  paddingVr: widget.paddingVr ?? UISizes.h4,
                  borderWidth: 0.5,
                  borderColor: isSelected
                      ? context.colors.primary
                      : isDisabled? null :  context.colors.surfaceContainerLow,
                  color: isSelected
                      ? context.colors.primary
                      : isDisabled ?context.colors.surfaceContainerLowest : Colors.transparent,
                  child: widget.itemBuilder(
                    context,
                    index,
                    isSelected,
                    isDisabled,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}