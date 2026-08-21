
import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  }) : assert(items.length >= 3, 'Items must be at least 3');

  @override
  Widget build(BuildContext context) {
    return Container(
padding: EdgeInsets.fromLTRB(
  UISizes.w4, UISizes.h12, UISizes.w4, context.safeBottomArea
),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAppOpacity(0.05),
            blurRadius: UISizes.r2,
            offset: Offset(0, -UISizes.h1),
          ),
        ],
        color: context.scaffoldBackgroundColor,
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          return Expanded(
            child: _NavBarItem(
              key: ValueKey('nav_item_$index'),
              item: items[index],
              isSelected: currentIndex == index,
              onTap: () => onTap(index),
            ),
          );
        }),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final color = isSelected ? context.colors.primary : context.colors.surfaceContainer ;
    return AppClick(
      onTap: onTap,
      child: Column(
        spacing: UISizes.sp6,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item.icon,
            color: color,
          size: UISizes.sp24,
          ),
          if (item.title != null)
            AppText(
              item.title!,
              height: 0,
              style: context.textTheme.bodyMedium,
              maxLines: 2,
              textAlign: TextAlign.center,
              color: color
            ),
        ],
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String? title;
  final IconData? selectedIcon;
  final String? badge;
  const BottomNavItem({
    required this.icon,
    this.badge,
    this.selectedIcon,
    this.title,
  });
}
