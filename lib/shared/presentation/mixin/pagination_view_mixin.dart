import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/models/pagination_data.dart';

typedef PaginationFooterBuilder =
    Widget Function(bool hasMore, bool isLoadingMore);
typedef PaginationHeaderBuilder = Widget Function(int totalViewed, int total);

mixin PaginationViewMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();

  bool isLoadingMore = false;
  double get loadMoreThreshold => 200;
  PaginationData data = PaginationData.empty();

  void initPagination(PaginationData? value) {
    scrollController.addListener(_onScroll);
    if (value == null) return;
    data = value;
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!scrollController.hasClients || isLoadingMore) return;
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - loadMoreThreshold) {
      loadMore();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !data.hasMore) return;
    setState(() => isLoadingMore = true);
    try {
      await onLoadMore();
    } finally {
      if (mounted) {
        setState(() => isLoadingMore = false);
      }
    }
  }

  Future<void> onLoadMore();

  PaginationFooterBuilder get paginationFooterBuilder =>
      (hasMore, isLoadingMore) {
        if (isLoadingMore) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!hasMore && data.currentPage != 1) {
          return Center(
            child: AppText(
              "لا يوجد المزيد",
              style: context.textTheme.labelLarge,
              color: context.colors.surfaceContainer,
            ),
          );
        }

        return const SizedBox.shrink();
      };
  PaginationHeaderBuilder get paginationHeaderBuilder =>
      (totalViewed, total) => SectionHeader(
        paddingVr: 0,
        titleStyle: context.textTheme.labelMedium?.copyWith(
          color: context.colors.surfaceContainer,
        ),
        title: "$totalViewed من اجمالى $total",
      );

  Widget paginationFooter() {
    return paginationFooterBuilder(data.hasMore, isLoadingMore);
  }
  Widget paginationHeader() {
    return paginationHeaderBuilder(data.data.length, data.totalCount);
  }
}
