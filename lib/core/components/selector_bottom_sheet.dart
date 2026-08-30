import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_list_tile.dart';
import 'package:shefaa/core/components/app_ribbon.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class SelectorBottomSheetData<T> {
  final String title;
  final String? subTitle;
  final Widget Function(bool)? leading;
  final T id;
  final RibbonData? ribbon;
  final bool selected;

  const SelectorBottomSheetData({
    required this.title,
    this.subTitle,
    this.leading,
    required this.id,
    this.ribbon,
    this.selected = false,
  });
}

class SelectorBottomSheet extends StatelessWidget {
  final String? title;
  final Widget? header;
  final Widget? footer;
  final List<SelectorBottomSheetData> data;
  final bool showTrailing;
  final Color? background, border;
  final double? borderRadius;
  final TextStyle? itemTextStyle;
  final TextStyle? titleStyle;
  final bool showHeadline;
  final Widget? trailing;
  final ScrollPhysics? physics;
  final double? spacing;
  final double? itemGap;
  final double borderWidth;
  final EdgeInsets? contentPadding;
  final EdgeInsets? itemMargin;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final TextStyle? subtitleStyle;
  final Color? closeIconColor;
  final double? closeIconSize;
  final MainAxisAlignment headerAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool showCloseIcon;
  final void Function(dynamic id)? onItemTap;
  final Widget Function(BuildContext context, SelectorBottomSheetData item)?
  itemBuilder;

  const SelectorBottomSheet({
    super.key,
    this.header,
    this.footer,
    this.itemTextStyle,
    this.showTrailing = false,
    this.title,
    this.showHeadline = true,
    required this.data,
    this.physics,
    this.trailing,
    this.background,
    this.border,
    this.titleStyle,
    this.borderRadius,
    this.spacing,
    this.itemGap,
    this.borderWidth = 1,
    this.contentPadding,
    this.itemMargin,
    this.selectedColor,
    this.selectedTextColor,
    this.subtitleStyle,
    this.closeIconColor,
    this.closeIconSize,
    this.headerAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.showCloseIcon = true,
    this.onItemTap,
    this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: physics,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        spacing: spacing ?? UISizes.h8,
        children: [
          if (showHeadline)
            Row(
              mainAxisAlignment: headerAlignment,
              children: [
                AppText(
                  title,
                  style: titleStyle ?? context.textTheme.labelMedium,
                ),
                if (showCloseIcon)
                  CircleIconButton(
                    AppIcons.close,
                    onTap: context.pop,
                    iconColor: closeIconColor,
                    backgroundColor: closeIconColor?.light,
                    iconSize: closeIconSize,
                  ),
              ],
            ),
          ?header,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, _) => VGap(itemGap ?? UISizes.h8),
            itemBuilder: (context, i) => itemBuilder != null
                ? itemBuilder!(context, data[i])
                : AppClick(
                    onTap: () => onItemTap != null
                        ? onItemTap!(data[i].id)
                        : context.pop(data[i].id),
                    child: _item(data[i]),
                  ),
            itemCount: data.length,
          ),
          ?footer,
        ],
      ),
    );
  }

  Widget _item(SelectorBottomSheetData data) => Builder(
    builder: (context) => AppRibbon(
      enabled: data.ribbon != null,
      data: data.ribbon,
      child: Container(
        margin: itemMargin,
        decoration: BoxDecoration(
          color:
              background ??
              (data.selected
                  ? (selectedColor ?? context.colors.primary)
                  : null),
          border: Border.all(
            color: border ?? context.colors.surfaceContainerLow,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? UISizes.r12),
        ),
        child: AppListTile(
          contentPadding: contentPadding,
          showLeading: data.leading != null,
          customLeading: data.leading?.call(data.selected),
          title: data.title,
          titleStyle: (itemTextStyle ?? context.textTheme.labelSmall)?.copyWith(
            color: data.selected
                ? (selectedTextColor ?? context.colors.onPrimary)
                : null,
          ),
          subtitle: data.subTitle,
          subtitleStyle:
              subtitleStyle ??
              context.textTheme.bodySmall?.copyWith(
                color: data.selected
                    ? (selectedTextColor ?? context.colors.onPrimary)
                    : null,
              ),
          customTrailing: trailing,
          showTrailing: showTrailing,
        ),
      ),
    ),
  );
}
