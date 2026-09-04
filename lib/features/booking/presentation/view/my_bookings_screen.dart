import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/booking/presentation/view/layout/booking_list.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: BookingStatus.values.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          "حجوزاتى",
          style: context.textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        TabBar(
          controller: _tabController,
          tabs: BookingStatus.values.map((e) => Tab(text: e.text)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: BookingStatus.values
                .map((e) => BookingList(status: e).paddingHr)
                .toList(),
          ),
        ),
      ],
    );
  }
}
