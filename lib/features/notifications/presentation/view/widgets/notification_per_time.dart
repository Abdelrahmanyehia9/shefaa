import 'package:flutter/material.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/features/notifications/presentation/view/layout/notification_list.dart';

class NotificationPerTime extends StatelessWidget {
  final String label ;
  const NotificationPerTime({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context).paddingHr,
        const NotificationList(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context)=>SectionHeader(
    title: label,
    titleStyle: context.textTheme.bodyLarge?.copyWith(
      color: context.colors.surfaceContainer,
    ),
    action: "وضع الكل كمقروء",
    actionStyle: context.textTheme.titleSmall,
  );
}
