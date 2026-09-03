import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BaseBlocConsumer<B extends BlocBase<BaseState<S>>, S>
    extends StatelessWidget {
  final Widget Function(BaseState<S> data)? builder;
  final Widget Function()? loadingBuilder;
  final Widget Function(S data)? successBuilder;
  final Widget Function(AppException error)? failureBuilder;
  final Widget Function()? emptyBuilder;
  final void Function(S? data)? onSuccess;
  final void Function()? onLoading;
  final void Function(AppException error)? onFailure;
  final void Function()? onEmpty;
  final bool shimmerLoading ;
  final void Function(BaseState<S> s)? onLoaded;

  final B? bloc;

  const BaseBlocConsumer({
    super.key,
    this.bloc,
    this.builder,
    this.loadingBuilder,
    this.successBuilder,
    this.failureBuilder,
    this.emptyBuilder,
    this.onLoaded,
    this.onSuccess,
    this.onLoading,
    this.onFailure,
    this.onEmpty,
    this.shimmerLoading = true
  });

  @override
  Widget build(BuildContext context) {
    final B cubit = bloc ?? context.read<B>();
    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        enableSwitchAnimation: true,
        effect: ShimmerEffect(
          baseColor: context.colors.surfaceContainerLowest,
          highlightColor: context.colors.surface,
        ),
        containersColor: Theme.of(context).cardTheme.color,
      ),

      child: BlocConsumer<B, BaseState<S>>(
        bloc: cubit,
        listener: (context, state) {
          if (state.isFailure && onFailure != null) {
            onFailure!(state.error!);
          } else if (state.isLoading && onLoading != null) {
            onLoading!();
          } else if (state.isSuccess && onSuccess != null) {
            onSuccess!(state.data);
          } else if (state.isEmpty && onEmpty != null) {
            onEmpty!();
          } else if (!state.isInitial &&
              !state.isLoading &&
              onLoaded != null &&
              onSuccess == null &&
              onFailure == null) {
            onLoaded?.call(state);
          }
        },
        builder: (context, state) {
          if (state.isLoading && loadingBuilder != null) {
            return Skeletonizer(enabled: shimmerLoading,child: loadingBuilder!(),);
          }
          if (state.isSuccess && successBuilder != null) {
            return successBuilder!(state.data as S);
          }
          if (state.isFailure && failureBuilder != null) {
            return failureBuilder == null
                ? const SizedBox.shrink()
                : failureBuilder!(state.error!);
          }
          if (state.isEmpty && emptyBuilder != null) {
            return emptyBuilder == null
                ? const SizedBox.shrink()
                : emptyBuilder!();
          }
          return builder == null ? const SizedBox.shrink() : builder!(state);
        },
      ),
    );
  }
}
