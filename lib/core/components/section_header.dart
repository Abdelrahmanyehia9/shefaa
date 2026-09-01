import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/utils/text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final Widget? customAction;
  final GestureTapCallback? onAction;
  final bool hasAction;
  final double paddingVr;

  final TextStyle? titleStyle, actionStyle;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.customAction,
    this.onAction,
    this.hasAction = true,
    this.actionStyle,
    this.titleStyle,
    this.paddingVr = 12,
  });

  factory SectionHeader.smallHeader(
    String title, {
    TextStyle? style,
    double? paddingVr,
    String? action,
    GestureTapCallback? onAction,
    TextStyle? actionStyle,
    Widget? customAction,
  }) => SectionHeader(
    title: title,
    hasAction: action != null || customAction != null,
    action: action,
    customAction: customAction,
    onAction: onAction,
    actionStyle: actionStyle,
    paddingVr: paddingVr ?? 8,
    titleStyle: style ?? TextStyles.titleSmall,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(title, style: titleStyle ?? context.textTheme.titleMedium),
        if (hasAction) AppClick(onTap: onAction, child: buildAction(context)),
      ],
    );
  }

  Widget buildAction(BuildContext context) =>
      customAction ??
      AppText(
        action,
        style: actionStyle ?? context.textTheme.titleSmall,
        color: context.colors.primary,
      ).appPaddingVr(paddingVr).appPaddingHr(paddingVr * .5);
}
