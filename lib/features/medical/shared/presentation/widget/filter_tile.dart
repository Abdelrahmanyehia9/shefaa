import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/features/medical/shared/presentation/widget/filters_config.dart';




class FilterTile extends StatelessWidget {
  final FilterConfig config;
  final bool initiallyExpanded;

  const FilterTile({
    super.key,
    required this.config,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      title: AppText(config.title, style: context.textTheme.labelLarge),
      subtitle: AppText(
        config.buildSubtitle(),
        style: context.textTheme.bodyMedium,
        color: context.colors.surfaceContainer,
      ),
      children: [config.buildContent(context)],
    );
  }
}