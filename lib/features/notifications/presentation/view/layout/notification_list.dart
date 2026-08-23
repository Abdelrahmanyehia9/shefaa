import 'package:flutter/material.dart';
import 'package:shefaa/features/notifications/presentation/view/widgets/notification_card.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 3,
        itemBuilder: (context, i)=> NotificationCard(
          isRead: i != 1,
        )
    );
  }
}
