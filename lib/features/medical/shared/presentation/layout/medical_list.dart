import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_refreshable.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/shared/presentation/controller/base_medical_cubit.dart';
import 'package:shefaa/shared/presentation/mixin/pagination_view_mixin.dart';

class MedicalList<C extends BaseMedicalCubit<T>, T>

    extends StatefulWidget {
  final Widget Function(
      List<T> items, {
      required ScrollController controller,
      Widget? footer,
      required bool heroEnabled,
      }) itemListBuilder;
  final List<T> Function() mockItems;
  final void Function(PaginationData<T>?data)? onSuccess ;

  const MedicalList({
    super.key,
    required this.itemListBuilder,
    required this.mockItems,
    this.onSuccess

  });

  @override
  State<MedicalList<C, T>> createState() =>
      _MedicalListState<C, T>();
}

class _MedicalListState<C extends BaseMedicalCubit<T>, T>
    extends State<MedicalList<C, T>>
    with PaginationViewMixin<MedicalList<C, T>> {
  @override
  Widget build(BuildContext context) {
    return AppRefreshable(
      onRefresh: () => _onRefresh(context),
      child: BaseBlocConsumer<C, PaginationData<T>>(
        onSuccess: (d){
          initPagination(d);
          widget.onSuccess?.call(d) ;
        },
        successBuilder: (c) {
          if(c.data.isEmpty)return AppStates.empty(mainAxisAlignment: MainAxisAlignment.start,size: UISizes.sp24,);
          return widget.itemListBuilder(
          c.data,
          controller: scrollController,
          footer: paginationFooter(),
          heroEnabled: true,
        );
        },
        loadingBuilder: () => widget.itemListBuilder(
          widget.mockItems(),
          controller: scrollController,
          heroEnabled: false,
        ),
      ),
    ) ;

  }

  Future<void> _onRefresh(BuildContext context) => context.read<C>().init(forceRefresh: true);

  @override
  Future<void> onLoadMore() => context.read<C>().loadMoreItems();

}