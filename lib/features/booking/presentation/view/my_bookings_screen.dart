import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/extensions/bookings.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/controller/get_bookings_cubit.dart';
import 'package:shefaa/features/booking/presentation/view/layout/booking_list.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_view_mixin.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin, PaginationViewMixin {
  late final TabController _tabController;

  final tabs = [null, ...BookingStatus.values];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Column(
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
        tabs: tabs.map((e) => Tab(text: e?.text ?? "الجميع")).toList(),
      ),
      Expanded(
        child:
            BaseBlocConsumer<GetBookingsCubit, PaginationData<BookingEntity>>(
              successBuilder: (b) => _buildTabs(b.data),
              loadingBuilder: () => _buildTabs(BookingEntity.mock.fakeList(12)),
            ),
      ),
    ],
  );

  Widget _buildTabs(List<BookingEntity> bookings) {
    List<BookingEntity> bookingsFromStatus(
      BookingStatus? status,
      List<BookingEntity> bookings,
    ) {
      if (status == null) return bookings;
      if (status.iCancelled) return bookings.cancelledBookings;
      if (status.isUpcoming) return bookings.upcomingBookings;
      return bookings.completedBookings;
    }

    return TabBarView(
      controller: _tabController,
      children: tabs.map((status) {
        final list = bookingsFromStatus(status, bookings);
        return list.isEmpty
            ? ResultView(
                type: ResultType.noResult,
                size: UISizes.sp28,
                mainAxisAlignment: MainAxisAlignment.start,
                message: "لا يوجد حجوزات هنا",
                footer: status?.isUpcoming == true
                    ? AppButton(
                        fixedSize: Size(UISizes.w220, UISizes.sp40),
                        child: AppIconText(
                          text: "حجز جديد",
                          textStyle: context.textTheme.labelMedium,
                          iconSize: UISizes.sp16,
                          icon: AppIcons.add,
                          color: context.colors.onPrimary,
                        ),
                      )
                    : null,
              )
            : BookingList(
                controller: scrollController,
                bookings: list,
              ).paddingHr;
      }).toList(),
    );
  }

  @override
  Future<void> onLoadMore() {
    final i = _tabController.index;
    return context.read<GetBookingsCubit>().loadMore(
      i == 0 ? null : BookingStatus.values[i - 1],
    );
  }
}
