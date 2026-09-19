import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_refreshable.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/enum/medical_type.dart';
import 'package:shefaa/core/extensions/bookings.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/controller/get_bookings_cubit.dart';
import 'package:shefaa/features/booking/presentation/view/layout/booking_list.dart';
import 'package:shefaa/features/medical/shared/presentation/medical_screen.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_view_mixin.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin, PaginationViewMixin {
  late final TabController _tabController;

  static const _tabs = [null, ...BookingStatus.values];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Column(
    spacing: UISizes.h16,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      AppText(
        "حجوزاتي",
        style: context.textTheme.labelLarge,
        textAlign: TextAlign.center,
      ),
      TabBar(
        controller: _tabController,
        tabs: _tabs.map((e) => Tab(text: e?.text ?? "الجميع")).toList(),
      ),
      Expanded(
        child:
            BaseBlocConsumer<GetBookingsCubit, PaginationData<BookingEntity>>(
              successBuilder: (state) =>
                  _buildTabs(state.data, total: state.totalCount),
              loadingBuilder: () => _buildTabs(BookingEntity.mock.fakeList(12)),
            ),
      ),
    ],
  );

  Widget _buildTabs(List<BookingEntity> bookings, {int total = 0}) {
    return TabBarView(
      controller: _tabController,
      children: _tabs.map((status) {
        final list = switch (status) {
          null => bookings,
          _ when status.iCancelled => bookings.cancelledBookings,
          _ when status.isUpcoming => bookings.upcomingBookings,
          _ => bookings.completedBookings,
        };

        return list.isEmpty
            ? ResultView(
                type: ResultType.noResult,
                size: UISizes.sp24,
                mainAxisAlignment: MainAxisAlignment.start,
                message: "لا توجد حجوزات حتى الآن، احجز موعدك الآن وسيظهر هنا.",
                footer: status?.isUpcoming ??true
                    ? AppButton(
                  onTap: ()=>context.pushNamed(Routes.medical, arguments: const MedicalScreenArgs(type: MedicalType.doctor)),
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
            : AppRefreshable(
                onRefresh: () => context.read<GetBookingsCubit>().loadFirstPage(
                  _tabs[_tabController.index],
                  forceRefresh: true,
                ),
                child: BookingList(
                  header: SectionHeader(
                    paddingVr: 0,
                    title: "- الإجمالي ${list.length} من $total",
                    titleStyle: context.textTheme.labelMedium?.copyWith(
                      color: context.colors.surfaceContainerLow,
                    ),
                  ),
                  footer: paginationFooter(),
                  controller: scrollController,
                  bookings: list,
                ).paddingHr,
              );
      }).toList(),
    );
  }

  @override
  Future<void> onLoadMore() {
    final index = _tabController.index;
    return context.read<GetBookingsCubit>().loadMore(
      index == 0 ? null : BookingStatus.values[index - 1],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
