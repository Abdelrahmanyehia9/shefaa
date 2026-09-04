import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_refreshable.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/shared/presentation/controller/base_medical_cubit.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_view_mixin.dart';

class MedicalLayout<C extends BaseMedicalCubit<T>, T>

    extends StatefulWidget {
  final Widget Function(
      List<T> items, {
      required ScrollController controller,
      Widget? footer,
      required bool heroEnabled,
      }) itemListBuilder;
  final List<T> Function() mockItems;

  const MedicalLayout({
    super.key,
    required this.itemListBuilder,
    required this.mockItems,
  });

  @override
  State<MedicalLayout<C, T>> createState() =>
      _MedicalLayoutState<C, T>();
}

class _MedicalLayoutState<C extends BaseMedicalCubit<T>, T>
    extends State<MedicalLayout<C, T>>
    with PaginationViewMixin<MedicalLayout<C, T>> {
  @override
  Widget build(BuildContext context) {
    return AppRefreshable(
      onRefresh: () => _onRefresh(context),
      child: BaseBlocConsumer<C, PaginationData<T>>(
        onSuccess: initPagination,
        successBuilder: (c) => widget.itemListBuilder(
          c.data,
          controller: scrollController,
          footer: paginationFooter(),
          heroEnabled: true,
        ),
        loadingBuilder: () => widget.itemListBuilder(
          widget.mockItems(),
          controller: scrollController,
          heroEnabled: false,
        ),
      ),
    ) ;

  }

  Future<void> _onRefresh(BuildContext context) =>
      context.read<C>().getAll(forceRefresh: true);

  @override
  Future<void> onLoadMore() => context.read<C>().loadMoreItems();

}